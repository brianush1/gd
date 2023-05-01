import gd.internal.application;
import gd.internal.window;
import gd.timer;
import gd.bindings.gl;
import gd.graphics;
import gd.keycode;
import gd.math;
import std.datetime;
import std.stdio;
import std.datetime;
import std.conv;
import gd.cursor;
import gd.graphics;

void main() {
	WindowInitOptions options;
	options.initialState = WindowState.Visible;
	options.title = "Demo Window";

	Window win = application.display.createWindow(options);

	win.onKeyPress.connect((KeyInfo info) {
		if (info.logical == KeyCode.Escape) {
			application.deactivate();
		}
	});

	GraphicsContext gc = application.display.headlessGraphicsContext;

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
				FragColor = texture(uTexture, uvAttrib) + vertexColor;
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

	Vertex[] vertices = [];

	vertices ~= [
		Vertex(FVec2(-.5, -.5), FVec2(0, 0)),
		Vertex(FVec2(0.5, -.5), FVec2(1, 0)),
		Vertex(FVec2(0.5, 0.5), FVec2(1, 1)),
		Vertex(FVec2(-.5, 0.5), FVec2(0, 1)),
	];

	Vertex[] polygonVertices;
	polygonVertices ~= Vertex(FVec2(-1, -1), FVec2(0, 0));
	foreach (v; polygon) {
		polygonVertices ~= Vertex(v, FVec2(0, 0));
	}

	Mesh mesh = gc.createMesh(
		VertexFormat()
			.add("pos", AttributeType.FVec2)
			.add("uv", AttributeType.FVec2),
		MeshUsage.Static,
	);
	mesh.upload(vertices);

	Mesh polygonMesh = gc.createMesh(
		VertexFormat()
			.add("pos", AttributeType.FVec2)
			.add("uv", AttributeType.FVec2),
		MeshUsage.Static,
	);
	polygonMesh.upload(polygonVertices);

	Image img = gc.createImage(IVec2(640, 480));

	gc.renderTarget = img;
	gc.viewport(IVec2(0, 0), IVec2(640, 480));
	gc.clearColor(Color.fromHex("#ff7f00"));
	shader.setUniform("color", Color.fromHex("#ff0"));
	shader.setUniform("uTexture", null);
	gc.draw(shader, polygonMesh, 0, polygonVertices.length, DrawMode.TriangleFan);
	gc.renderTarget = null;

	import imageformats : write_png;
	uint[] data = img.getPixels(IRect(0, 0, 640, 480));
	write_png("test.png", 640, 480, cast(ubyte[]) data);

	win.setPaintHandler((IRect region, IVec2 bufferSize, GraphicsContext context) {
		context.clearColor(Color.fromHex("#eee"));
		context.clearDepth();

		context.depthTest = false;
		// context.cullBack = false;
		// context.blend = BlendFuncs.Add;

		// shader.setUniform("color", Color.fromHex("#000"));
		// shader.setUniform("uTexture", img);
		// shader.setUniform("color", Color.fromHex("#ff00ff"));
		// shader.setUniform("uTexture", null);
		// context.draw(shader, mesh, 0, vertices.length, DrawMode.TriangleFan);
		// shader.setUniform("color", Color.fromHex("#ff0"));
		// shader.setUniform("uTexture", null);
		// context.draw(shader, polygonMesh, 0, polygonVertices.length, DrawMode.TriangleFan);

		return IRect(IVec2(0, 0), bufferSize);
	});

	win.onCloseRequest.connect({
		writeln("closing");
		application.deactivate();
	});
}
