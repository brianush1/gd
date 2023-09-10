module gd.graphics.context;
import gd.graphics.image;
import gd.graphics.color;
import gd.graphics.text;
import gd.geom.area;
import gd.geom.path;
import gd.shaders;
import gd.math;

import gd.internal.application;
import gd.internal.gpu;

enum Antialias {
	Grayscale,
	None,
	Subpixel,
}

class Graphics {

	private BitmapImage image;

	private this(BitmapImage image) { this.image = image; }

	static Graphics fromImage(BitmapImage image) { return new Graphics(image); }

	private inout(GPUImage) surface() inout @property { return image.gpuImage; }

	private IRect m_clipRegion = IRect(0, 0, int.max, int.max);
	void clipRegion(IRect region) { m_clipRegion = region; }

	void clear(Color color) {
		WriteInfo info = {
			clip: m_clipRegion
		};
		gpu.clearColorBuffer(surface, FVec4(color.r, color.g, color.b, color.a), info);
	}

	void drawString(Color color, string str, Font font, Rect layoutRectangle) {
		import gd.graphics.text.shaping : ShapedGlyph, shapeText, TextDrawInfo;

		ShapedGlyph[] glyphs = shapeText(TextDrawInfo(str, font.faces, font.size, layoutRectangle));
		foreach (s; glyphs) {
			Path path = s.glyph.outline;
			fill(color,
				Area(FillRule.EvenOdd, path),
				FMat4(FVec3(s.position, 0)) * FMat4.scale(FVec3(s.scale, 0)),
				Antialias.Subpixel,
			);
		}
	}

	void fill(Color color, Area area, FMat4 transform = FMat4.init, Antialias antialias = Antialias.Grayscale) {
		Vertex[] geometry;

		FVec2 at, lastMove;
		foreach (Path.Command cmd; area.outline) {
			FVec2 prev = at;
			final switch (cmd.type) {
			case CommandType.Move:
				lastMove = at = FVec2(cmd.move.point);
				break;
			case CommandType.Line:
				at = FVec2(cmd.line.end);
				geometry ~= [Vertex(lastMove), Vertex(prev), Vertex(at)];
				break;
			case CommandType.BezierQuad:
				at = FVec2(cmd.bezierQuad.end);
				geometry ~= [Vertex(lastMove), Vertex(prev), Vertex(at)];
				geometry ~= [
					Vertex(prev, FVec2(0, 0)),
					Vertex(FVec2(cmd.bezierQuad.c1), FVec2(1, 0)),
					Vertex(at, FVec2(0, 1)),
				];
				break;
			case CommandType.BezierCubic:
				at = FVec2(cmd.bezierCubic.end); // FIXME: actually render properly
				geometry ~= [Vertex(lastMove), Vertex(prev), Vertex(at)];
				geometry ~= [
					Vertex(prev, FVec2(0, 0)),
					Vertex(FVec2((cmd.bezierCubic.c1 + cmd.bezierCubic.c2) / 2), FVec2(1, 0)),
					Vertex(at, FVec2(0, 1)),
				];
				break;
			case CommandType.Arc:
				assert(0);
			case CommandType.Close:
				at = FVec2(lastMove);
				break;
			}
		}

		foreach (ref v; geometry) {
			// TODO: do transformations in the vertex shader
			v.pos = (transform * FMat4(FVec3(v.pos, 0))).position.xy;
		}

		meshBuffer.upload(geometry);

		immutable(Sample)[] samples;
		final switch (antialias) {
		case Antialias.Grayscale:
			samples = grayscaleSamples;
			break;
		case Antialias.None:
			samples = aliasedSamples;
			break;
		case Antialias.Subpixel:
			samples = rgbSubpixelSamples;
			break;
		}
		shader2d.samples[0 .. samples.length] = samples[];
		gpu.clearColorBuffer(sampled, IVec4(0, 0, 0, 1), WriteInfo());
		DrawInfo info = {
			mode: DrawMode.Triangles,
			flags: DrawFlags.Blend,
			mesh: gpu.createMesh!Vertex(meshBuffer),
			viewport: IRect(IVec2(), sampled.size),
			write: { clip: m_clipRegion }, // TODO: move clipRegion into a uniform in shaderSubpixelBlit
			startVertex: 0,
			numVertices: geometry.length,
			instanceCount: samples.length,
		};
		gpu.draw(sampled, shader2d, info);

		shaderSubpixelBlit.target = Sampler2D(surface);
		shaderSubpixelBlit.sampled = USampler2D(sampled);
		shaderSubpixelBlit.sampledSize = sampled.size;
		shaderSubpixelBlit.contrastFactor = 1;
		shaderSubpixelBlit.antialias = antialias;
		shaderSubpixelBlit.color = FVec4(color.r, color.g, color.b, color.a);
		DrawInfo infoBlit = {
			mode: DrawMode.TriangleFan,
			flags: DrawFlags.None,
			mesh: gpu.createMesh!Vertex(screenQuadBuffer),
			viewport: IRect(IVec2(), surface.size),
			startVertex: 0,
			numVertices: 4,
		};
		gpu.draw(image.backBuffer, shaderSubpixelBlit, infoBlit);
		image.swapBuffers();
	}

}

GPUContext gpu() { return application.display.gpuContext; }

private:

Shader2D shader2d;
ShaderSubpixelBlit shaderSubpixelBlit;
GPUBuffer meshBuffer, screenQuadBuffer;
GPUImage sampled;

shared static this() {
	meshBuffer = gpu.createBuffer(BufferUsage.Dynamic);
	screenQuadBuffer = gpu.createBuffer(BufferUsage.Static);
	screenQuadBuffer.upload([
		Vertex(FVec2(-1, -1), FVec2(0, 1)),
		Vertex(FVec2(1, -1), FVec2(1, 1)),
		Vertex(FVec2(1, 1), FVec2(1, 0)),
		Vertex(FVec2(-1, 1), FVec2(0, 0)),
	]);

	shader2d = new Shader2D();
	shaderSubpixelBlit = new ShaderSubpixelBlit();
	gpu.compileShader(shader2d);
	gpu.compileShader(shaderSubpixelBlit);

	// TODO: FIXME: dynamic sizing
	sampled = gpu.createImage(ImageFormat.R16U, IVec2(1920, 1080), null);
}

struct Sample {
	FVec2 translate;
	int color;
}

immutable(Sample[]) rgbSubpixelSamples = [
	// near subpixel
	Sample(-FVec2(1 - 5.5 / 12.0,  0.5 / 4.0), 1 << 0),
	Sample(-FVec2(1 - 4.5 / 12.0, -1.5 / 4.0), 1 << 1),
	Sample(-FVec2(1 - 3.5 / 12.0,  1.5 / 4.0), 1 << 2),
	Sample(-FVec2(1 - 2.5 / 12.0, -0.5 / 4.0), 1 << 3),

	// center subpixel
	Sample(-FVec2(-1.5 / 12.0,  0.5 / 4.0), 1 << 4),
	Sample(-FVec2(-0.5 / 12.0, -1.5 / 4.0), 1 << 5),
	Sample(-FVec2( 0.5 / 12.0,  1.5 / 4.0), 1 << 6),
	Sample(-FVec2( 1.5 / 12.0, -0.5 / 4.0), 1 << 7),

	// far subpixel
	Sample(-FVec2( 2.5 / 12.0,  0.5 / 4.0), 1 << 8),
	Sample(-FVec2( 3.5 / 12.0, -1.5 / 4.0), 1 << 9),
	Sample(-FVec2( 4.5 / 12.0,  1.5 / 4.0), 1 << 10),
	Sample(-FVec2( 5.5 / 12.0, -0.5 / 4.0), 1 << 11),
];

immutable(Sample[]) grayscaleSamples = [
	Sample(-FVec2(-3.5 / 8.0, -1.5 / 8.0), 1 << 0),
	Sample(-FVec2(-2.5 / 8.0,  2.5 / 8.0), 1 << 1),
	Sample(-FVec2(-1.5 / 8.0, -2.5 / 8.0), 1 << 2),
	Sample(-FVec2(-0.5 / 8.0,  0.5 / 8.0), 1 << 3),
	Sample(-FVec2( 0.5 / 8.0, -3.5 / 8.0), 1 << 4),
	Sample(-FVec2( 1.5 / 8.0,  3.5 / 8.0), 1 << 5),
	Sample(-FVec2( 2.5 / 8.0, -0.5 / 8.0), 1 << 6),
	Sample(-FVec2( 3.5 / 8.0,  1.5 / 8.0), 1 << 7),
];

immutable(Sample[]) aliasedSamples = [
	Sample(FVec2(0, 0), 1),
];

struct Vertex {
	FVec2 pos, uv;
}

final class Shader2D : Shader {

	Sample[12] samples;

	@Varying FVec2 uv;

	@Output IVec4 fragColor;

	VSOutput processVertex(Vertex v) {
		FVec2 pixelPos = v.pos + samples[instanceID].translate;
		FVec4 position = FVec4(pixelPos / viewport.size * FVec2(2, -2) + FVec2(-1, 1), 0, 1);
		uv = v.uv;
		return VSOutput(position);
	}

	void processFragment() {
		float v = uv.x / 2.0f + uv.y;
		if (v * v > uv.y)
			discard();

		fragColor = IVec4(samples[instanceID].color, 0, 0, 0);
	}

}

FVec3 subpx(IVec4 color) {
	uint v = color.r;

	float count(uint i) {
		float res = 0;
		if (i & 0b0001) res += 0.25f;
		if (i & 0b0010) res += 0.25f;
		if (i & 0b0100) res += 0.25f;
		if (i & 0b1000) res += 0.25f;
		return res;
	}

	return FVec3(
		count(v >> 0),
		count(v >> 4),
		count(v >> 8),
	);
}

final class ShaderSubpixelBlit : Shader {

	Sampler2D target;
	USampler2D sampled;
	IVec2 sampledSize;
	FVec4 color;
	float contrastFactor;
	Antialias antialias;

	@Varying FVec2 uv;

	@Output FVec4 fragColor;

	VSOutput processVertex(Vertex v) {
		FVec4 position = FVec4(v.pos, 0, 1);
		uv = v.uv;
		return VSOutput(position);
	}

	void processFragment() {
		FVec2 transformedUV = FVec2(0, 1) + FVec2(1, -1) * uv * (FVec2(viewport.size) / sampledSize);
		IVec4 sampleR = sampled.get(transformedUV);
		FVec4 targetColor = target.get(FVec2(0, 1) + FVec2(1, -1) * uv);

		if (antialias == Antialias.Subpixel) {
			IVec4 sampleL = sampled.get(transformedUV - FVec2(1.0f / sampledSize.x, 0));

			FVec3 sampleLP = subpx(sampleL);
			FVec3 sampleRP = subpx(sampleR);
			float s0 = sampleLP.b;
			float s1 = sampleLP.r;
			float s2 = sampleRP.g;
			float s3 = sampleRP.b;
			float s4 = sampleRP.r;

			float sr = mix(s1, (s0 + s1 + s2) / 3.0f, contrastFactor);
			float sg = mix(s2, (s1 + s2 + s3) / 3.0f, contrastFactor);
			float sb = mix(s3, (s2 + s3 + s4) / 3.0f, contrastFactor);

			fragColor = FVec4(
				mix(targetColor.r, color.r, sr * color.a),
				mix(targetColor.g, color.g, sg * color.a),
				mix(targetColor.b, color.b, sb * color.a),
				1.0,
			);
		}
		else if (antialias == Antialias.None) {
			// TODO: allow transparent targetColor

			int i = sampleR.r;
			float alpha = cast(float) i;
			fragColor = FVec4(
				mix(targetColor.r, color.r, alpha * color.a),
				mix(targetColor.g, color.g, alpha * color.a),
				mix(targetColor.b, color.b, alpha * color.a),
				1.0,
			);
		}
		else {
			// TODO: allow transparent targetColor

			int i = sampleR.r;
			float alpha = 0;
			if (i & 0b0000_0001) alpha += 0.125f;
			if (i & 0b0000_0010) alpha += 0.125f;
			if (i & 0b0000_0100) alpha += 0.125f;
			if (i & 0b0000_1000) alpha += 0.125f;
			if (i & 0b0001_0000) alpha += 0.125f;
			if (i & 0b0010_0000) alpha += 0.125f;
			if (i & 0b0100_0000) alpha += 0.125f;
			if (i & 0b1000_0000) alpha += 0.125f;

			fragColor = FVec4(
				mix(targetColor.r, color.r, alpha * color.a),
				mix(targetColor.g, color.g, alpha * color.a),
				mix(targetColor.b, color.b, alpha * color.a),
				1.0,
			);
		}
	}

}

final class ShaderBlit : Shader {

	Sampler2D source;

	@Varying FVec2 uv;

	@Output FVec4 fragColor;

	VSOutput processVertex(Vertex v) {
		FVec4 position = FVec4(v.pos, 0, 1);
		uv = FVec2(0, 1) + FVec2(1, -1) * v.uv;
		return VSOutput(position);
	}

	void processFragment() {
		fragColor = source.get(uv);
	}

}
