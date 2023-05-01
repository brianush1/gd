module gd.graphics.shader;
import gd.graphics.image;
import gd.graphics.color;
import gd.math;

enum ShaderType {
	Fragment,
	Vertex,
}

struct ShaderSource {
	ShaderType type;
	string source;
}

abstract class Shader {

	void setUniform(string name, float value);
	void setUniform(string name, int value);
	void setUniform(string name, FVec2 value);
	void setUniform(string name, FVec3 value);
	void setUniform(string name, FVec4 value);
	void setUniform(string name, Color value);
	void setUniform(string name, IVec2 value);
	void setUniform(string name, IVec3 value);
	void setUniform(string name, IVec4 value);
	void setUniform(string name, Mat4 value);
	void setUniform(string name, Frame2 value);
	void setUniform(string name, Frame3 value);
	void setUniform(string name, Image value);

}
