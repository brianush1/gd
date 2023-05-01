module gd.graphics.gl.mesh;
import gd.graphics.mesh;
import gd.bindings.gl;
import gd.graphics.gl.context;

class GLMesh : Mesh {

	GLGraphicsContext context;
	GL.UInt vao, buffer;
	MeshUsage usage;

	package this(GLGraphicsContext context, VertexFormat format, MeshUsage usage) {
		this.context = context;
		this.usage = usage;

		GL.genVertexArrays(1, &vao);
		GL.bindVertexArray(vao);

		GL.genBuffers(1, &buffer);
		GL.bindBuffer(GL.ARRAY_BUFFER, buffer);

		foreach (i, v; format.attributes) {
			GL.Int size;
			GL.Enum type;
			final switch (v.type) {
			case AttributeType.Float:
				size = 1;
				type = GL.FLOAT;
				break;
			case AttributeType.FVec2:
				size = 2;
				type = GL.FLOAT;
				break;
			case AttributeType.FVec3:
				size = 3;
				type = GL.FLOAT;
				break;
			case AttributeType.FVec4:
				size = 4;
				type = GL.FLOAT;
				break;
			case AttributeType.Int:
				size = 1;
				type = GL.INT;
				break;
			case AttributeType.IVec2:
				size = 2;
				type = GL.INT;
				break;
			case AttributeType.IVec3:
				size = 3;
				type = GL.INT;
				break;
			case AttributeType.IVec4:
				size = 4;
				type = GL.INT;
				break;
			}
			GL.vertexAttribPointer(cast(GL.UInt) i, size, type, false,
				cast(GL.Sizei) format.stride, cast(void*) v.byteOffset);
			GL.enableVertexAttribArray(cast(GL.UInt) i);
		}
	}

	/+protected override void disposeImpl() {
		GL.deleteVertexArrays(1, &vao);
		GL.deleteBuffers(1, &buffer);
	}+/

	override void upload(void[] data) {
		GL.bindVertexArray(vao);
		GL.bufferData(GL.ARRAY_BUFFER, cast(GL.Sizeiptr) data.length, data.ptr,
			usage == MeshUsage.Dynamic ? GL.STREAM_DRAW : GL.STATIC_DRAW,
		);
	}

}
