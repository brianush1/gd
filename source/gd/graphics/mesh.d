module gd.graphics.mesh;
import gd.resource;
import gd.bindings.gl;
import gd.math;

enum MeshUsage {

	/** Signals that the mesh will not be modified often */
	Static,

	/** Signals that the mesh will be modified often */
	Dynamic,

}

enum AttributeType {
	Float,
	FVec2,
	FVec3,
	FVec4,
	Int,
	IVec2,
	IVec3,
	IVec4,
}

size_t byteLength(AttributeType type) {
	final switch (type) {
		case AttributeType.Float: return float.sizeof;
		case AttributeType.FVec2: return FVec2.sizeof;
		case AttributeType.FVec3: return FVec3.sizeof;
		case AttributeType.FVec4: return FVec4.sizeof;
		case AttributeType.Int: return int.sizeof;
		case AttributeType.IVec2: return IVec2.sizeof;
		case AttributeType.IVec3: return IVec3.sizeof;
		case AttributeType.IVec4: return IVec4.sizeof;
	}
}

struct Attribute {
	string name;
	AttributeType type;
	size_t byteOffset;
}

struct VertexFormat {
	Attribute[] attributes;
	size_t stride;

	VertexFormat add(string name, AttributeType type) {
		// TODO: bind to input based on name; currently uses order
		attributes ~= Attribute(name, type, stride);
		stride += type.byteLength;
		return this;
	}
}

abstract class Mesh {

	void upload(void[] data);

}
