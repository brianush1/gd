import std.stdio;
import imageformats;
import gd.internal.application;
import gd;

void main() {
	/+GraphicsContext gc = application.display.headlessGraphicsContext;

	Shader shader = gc.createShader([
		ShaderSource(ShaderType.Vertex, q"(
			#version 330 core
			layout (location = 0) in vec2 pos;
			layout (location = 1) in vec2 uv;
			out vec4 vertexColor;
			out vec2 uvAttrib;
			uniform vec4 color;

			void main() {
				gl_Position = vec4(pos, 0.0, 1.0);
				uvAttrib = uv;
				vertexColor = color;
			}
		)"),
		ShaderSource(ShaderType.Fragment, q"(
			#version 330 core
			out vec4 FragColor;
			in vec4 vertexColor;
			in vec2 uvAttrib;
			uniform sampler2D uTexture;

			void main() {
				FragColor = vertexColor;
			}
		)"),
	]);

	FVec2[] polygon = [
		FVec2(-.5, -.5),
		FVec2(-.25, 0),
		FVec2(-.5, .5),
		FVec2(0, .25),
		FVec2(.5, .5),
		FVec2(.25, 0),
		FVec2(.5, -.5),
		FVec2(0, -.25),
		FVec2(-.5, -.5),
	];

	struct Vertex {
		FVec2 pos;
		FVec2 uv;
	}

	Vertex[] polygonVertices;
	polygonVertices ~= Vertex(FVec2(-1, -1), FVec2(0, 0));
	foreach (v; polygon) {
		polygonVertices ~= Vertex(v, FVec2(0, 0));
	}

	Mesh polygonMesh = gc.createMesh(
		VertexFormat()
			.add("pos", AttributeType.FVec2)
			.add("uv", AttributeType.FVec2),
		MeshUsage.Static,
	);
	polygonMesh.upload(polygonVertices);+/

	Image img = new Image(640, 480);
	Graphics g = Graphics.fromImage(img);

	g.clearColor(Color(0, 0, 0, 1));

	// gc.draw(shader, polygonMesh, 0, polygonVertices.length, DrawMode.TriangleFan);

	// img.save("test.png");
	write_png("test.png", 640, 480, cast(ubyte[]) img.getPixels(IRect(0, 0, 640, 480)));
}
