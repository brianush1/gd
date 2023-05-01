module gd.graphics.gl.context;
import gd.graphics.gl.exception;
import gd.graphics.gl.shader;
import gd.graphics.gl.image;
import gd.graphics.gl.mesh;
import gd.graphics;
import gd.bindings.gl;
import gd.math;
import std.exception;

class GLGraphicsContext : GraphicsContext {

	package GLShader currentShader;

	package(gd) void delegate() makeCurrent;

	package(gd) this() {}

	override GLShader createShader(ShaderSource[] sources) {
		makeCurrent();
		return new GLShader(this, sources);
	}

	override GLMesh createMesh(VertexFormat format, MeshUsage usage) {
		makeCurrent();
		return new GLMesh(this, format, usage);
	}

	override GLImage createImage(IVec2 size, const(uint)[] data) {
		makeCurrent();
		return new GLImage(this, size, data);
	}

	private GLImage m_renderTarget;
	override inout(GLImage) renderTarget() inout @property { return m_renderTarget; }

	override void renderTarget(Image image_) @property {
		GLImage image = cast(GLImage) image_;
		if (image_ !is null && image is null) {
			throw new GLException("cannot set renderTarget to non-OpenGL texture on OpenGL context");
		}

		makeCurrent();
		m_renderTarget = image;
		if (image is null) {
			GL.bindFramebuffer(GL.FRAMEBUFFER, 0);
		}
		else {
			image.initializeFBO();
			GL.bindFramebuffer(GL.FRAMEBUFFER, image.fbo);
		}
	}

	override void clearColor(Color color) {
		makeCurrent();

		GL.clearColor(color.r, color.g, color.b, color.a);
		GL.clear(GL.COLOR_BUFFER_BIT);
	}

	override void clearStencil(ubyte value) {
		makeCurrent();

		GL.clearStencil(value);
		GL.clear(GL.STENCIL_BUFFER_BIT);
	}

	override void clearDepth() {
		makeCurrent();

		GL.clear(GL.DEPTH_BUFFER_BIT);
	}

	override void stencilSeparate(Stencil frontFace, Stencil backFace) {
		GL.Enum convertStencilFunc(StencilFilter filter) {
			final switch (filter) {
				case StencilFilter.Always: return GL.ALWAYS;
				case StencilFilter.Never: return GL.NEVER;
				case StencilFilter.Less: return GL.LESS;
				case StencilFilter.LessEqual: return GL.LEQUAL;
				case StencilFilter.Greater: return GL.GREATER;
				case StencilFilter.GreaterEqual: return GL.GEQUAL;
				case StencilFilter.Equal: return GL.EQUAL;
				case StencilFilter.NotEqual: return GL.NOTEQUAL;
			}
		}

		GL.Enum convertStencilOp(StencilOp op) {
			final switch (op) {
				case StencilOp.NoChange: return GL.KEEP;
				case StencilOp.Zero: return GL.ZERO;
				case StencilOp.Set: return GL.REPLACE;
				case StencilOp.Increment: return GL.INCR;
				case StencilOp.Decrement: return GL.DECR;
				case StencilOp.IncrementWrap: return GL.INCR_WRAP;
				case StencilOp.DecrementWrap: return GL.DECR_WRAP;
				case StencilOp.Invert: return GL.INVERT;
			}
		}

		if (frontFace.filter == StencilFilter.Always
				&& frontFace.stencilFail == StencilOp.NoChange
				&& frontFace.depthFail == StencilOp.NoChange
				&& frontFace.pass == StencilOp.NoChange
				&& backFace.filter == StencilFilter.Always
				&& backFace.stencilFail == StencilOp.NoChange
				&& backFace.depthFail == StencilOp.NoChange
				&& backFace.pass == StencilOp.NoChange) {
			GL.disable(GL.STENCIL_TEST);
			return;
		}

		GL.enable(GL.STENCIL_TEST);

		if (frontFace.writeMask == backFace.writeMask) {
			GL.stencilMask(frontFace.writeMask);
		}
		else {
			GL.stencilMaskSeparate(GL.FRONT, frontFace.writeMask);
			GL.stencilMaskSeparate(GL.BACK, backFace.writeMask);
		}

		if (frontFace.filter == backFace.filter
				&& frontFace.refValue == backFace.refValue
				&& frontFace.readMask == backFace.readMask) {
			GL.stencilFunc(convertStencilFunc(frontFace.filter), frontFace.refValue, frontFace.readMask);
		}
		else {
			GL.stencilFuncSeparate(GL.FRONT, convertStencilFunc(frontFace.filter), frontFace.refValue, frontFace.readMask);
			GL.stencilFuncSeparate(GL.BACK, convertStencilFunc(backFace.filter), backFace.refValue, backFace.readMask);
		}

		if (frontFace.stencilFail == backFace.stencilFail
				&& frontFace.depthFail == backFace.depthFail
				&& frontFace.pass == backFace.pass) {
			GL.stencilOp(
				convertStencilOp(frontFace.stencilFail),
				convertStencilOp(frontFace.depthFail),
				convertStencilOp(frontFace.pass),
			);
		}
		else {
			GL.stencilOpSeparate(GL.FRONT,
				convertStencilOp(frontFace.stencilFail),
				convertStencilOp(frontFace.depthFail),
				convertStencilOp(frontFace.pass),
			);
			GL.stencilOpSeparate(GL.BACK,
				convertStencilOp(backFace.stencilFail),
				convertStencilOp(backFace.depthFail),
				convertStencilOp(backFace.pass),
			);
		}
	}

	private BlendFunc _colorBlend;
	private BlendFunc _alphaBlend;

	// override BlendFunc colorBlend() const @property { return _colorBlend; }
	// override BlendFunc alphaBlend() const @property { return _alphaBlend; }
	// override BlendFunc blend() const @property { return _colorBlend; }

	private GL.Enum convBlendingOperation(BlendFunc.Op op) {
		final switch (op) {
			case BlendFunc.Op.Add: return GL.FUNC_ADD;
			case BlendFunc.Op.SrcMinusDst: return GL.FUNC_SUBTRACT;
			case BlendFunc.Op.DstMinusSrc: return GL.FUNC_REVERSE_SUBTRACT;
			case BlendFunc.Op.Min: return GL.MIN;
			case BlendFunc.Op.Max: return GL.MAX;
		}
	}

	private GL.Enum convBlendingFactor(BlendFunc.Factor factor) {
		final switch (factor) {
			case BlendFunc.Factor.Zero: return GL.ZERO;
			case BlendFunc.Factor.One: return GL.ONE;
			case BlendFunc.Factor.SrcColor: return GL.SRC_COLOR;
			case BlendFunc.Factor.DstColor: return GL.DST_COLOR;
			case BlendFunc.Factor.SrcAlpha: return GL.SRC_ALPHA;
			case BlendFunc.Factor.DstAlpha: return GL.DST_ALPHA;
			case BlendFunc.Factor.ConstColor: return GL.CONSTANT_COLOR;
			case BlendFunc.Factor.ConstAlpha: return GL.CONSTANT_ALPHA;
			case BlendFunc.Factor.OneMinusSrcColor: return GL.ONE_MINUS_SRC_COLOR;
			case BlendFunc.Factor.OneMinusDstColor: return GL.ONE_MINUS_DST_COLOR;
			case BlendFunc.Factor.OneMinusSrcAlpha: return GL.ONE_MINUS_SRC_ALPHA;
			case BlendFunc.Factor.OneMinusDstAlpha: return GL.ONE_MINUS_DST_ALPHA;
			case BlendFunc.Factor.OneMinusConstColor: return GL.ONE_MINUS_CONSTANT_COLOR;
			case BlendFunc.Factor.OneMinusConstAlpha: return GL.ONE_MINUS_CONSTANT_ALPHA;
		}
	}

	override void blendSeparate(BlendFunc color, BlendFunc alpha) {
		_colorBlend = color;
		_alphaBlend = alpha;

		// TODO: allow disabling blending

		GL.enable(GL.BLEND);

		if (color.op == alpha.op) {
			GL.blendEquation(convBlendingOperation(color.op));
		}
		else {
			GL.blendEquationSeparate(
				convBlendingOperation(color.op),
				convBlendingOperation(alpha.op),
			);
		}

		if (color.sfactor == alpha.sfactor && color.dfactor == alpha.dfactor) {
			GL.blendFunc(
				convBlendingFactor(color.sfactor),
				convBlendingFactor(color.dfactor),
			);
		}
		else {
			GL.blendFuncSeparate(
				convBlendingFactor(color.sfactor),
				convBlendingFactor(color.dfactor),
				convBlendingFactor(alpha.sfactor),
				convBlendingFactor(alpha.dfactor),
			);
		}

		GL.blendColor(
			color.constant.r,
			color.constant.g,
			color.constant.b,
			alpha.constant.a,
		);
	}

	override void viewport(IVec2 location, IVec2 size) {
		GL.viewport(location.x, location.y, size.x, size.y);
	}

	override void cullBack(bool value) @property {
		(value ? &GL.enable : &GL.disable)(GL.CULL_FACE);
	}

	override void depthTest(bool value) @property {
		(value ? &GL.enable : &GL.disable)(GL.DEPTH_TEST);
	}

	override void draw(Shader shader,
			Mesh mesh,
			size_t startVertex, size_t numVertices,
			DrawMode mode = DrawMode.Triangles) {
		enforce!GLException(cast(GLMesh) mesh, "Cannot draw non-GL mesh in GL context");
		enforce!GLException(cast(GLShader) shader, "Cannot use non-GL shader in GL context");

		makeCurrent();

		GLShader glShader = cast(GLShader) shader;
		glShader.useShader();

		foreach (i, texture; glShader.textures) {
			GL.activeTexture(GL.TEXTURE0 + cast(int) i);
			if (cast(GLImage) texture) {
				GL.bindTexture(GL.TEXTURE_2D, (cast(GLImage) texture).texture);
			}
			else {
				GL.bindTexture(GL.TEXTURE_2D, 0);
			}
		}

		GL.bindVertexArray((cast(GLMesh) mesh).vao);

		GL.Enum glMode;
		final switch (mode) {
		case DrawMode.Triangles:
			glMode = GL.TRIANGLES;
			break;
		case DrawMode.TriangleFan:
			glMode = GL.TRIANGLE_FAN;
			break;
		case DrawMode.TriangleStrip:
			glMode = GL.TRIANGLE_STRIP;
			break;
		}

		GL.drawArrays(glMode, cast(GL.Int) startVertex, cast(GL.Sizei) numVertices);
	}

	override void drawInstanced(Shader shader,
			Mesh mesh,
			size_t startVertex, size_t numVertices,
			size_t count,
			DrawMode mode = DrawMode.Triangles) {
		enforce!GLException(cast(GLMesh) mesh, "Cannot draw non-GL mesh in GL context");
		enforce!GLException(cast(GLShader) shader, "Cannot use non-GL shader in GL context");

		makeCurrent();

		GLShader glShader = cast(GLShader) shader;
		glShader.useShader();

		/+foreach (i, texture; glShader.textures) {
			GL.activeTexture(GL.TEXTURE0 + cast(int) i);
			if (cast(GLFramebuffer) texture) {
				GL.bindTexture(GL.TEXTURE_2D, (cast(GLFramebuffer) texture).texColorBuffer);
			}
			else if (cast(GLTexture) texture) {
				GL.bindTexture(GL.TEXTURE_2D, (cast(GLTexture) texture).texture);
			}
			else {
				GL.bindTexture(GL.TEXTURE_2D, 0);
			}
		}+/

		GL.bindVertexArray((cast(GLMesh) mesh).vao);

		GL.Enum glMode;
		final switch (mode) {
		case DrawMode.Triangles:
			glMode = GL.TRIANGLES;
			break;
		case DrawMode.TriangleFan:
			glMode = GL.TRIANGLE_FAN;
			break;
		case DrawMode.TriangleStrip:
			glMode = GL.TRIANGLE_STRIP;
			break;
		}

		GL.drawArraysInstanced(glMode, cast(GL.Int) startVertex, cast(GL.Sizei) numVertices, cast(GL.Sizei) count);
	}

}
