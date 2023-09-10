module gd.graphics.context__shadersource;
template Global(string name) if (name == "viewportPos") { enum Global = "tmp62909"; }
template Global(string name) if (name == "instanceID") { enum Global = "tmp78445"; }
template Global(string name) if (name == "viewportSize") { enum Global = "tmp8797"; }
struct C2gd8graphics7context8Shader2D {
	enum VertexSource = "struct d_Sample3899 {
	vec2 f0;
	int f1;
};
struct d_Vertex91214 {
	vec2 f0;
	vec2 f1;
};
struct d_VSOutput49174 {
	vec4 f0;
};
struct d_TRect45085 {
	ivec2 f0;
	ivec2 f1;
};
uniform d_Sample3899[12] tmp88252;
d_Sample3899[12] d_samples85755;
out vec2 tmp17761;
vec2 d_uv11771;
uniform ivec2 tmp62909;
uniform ivec2 tmp8797;
d_VSOutput49174 d_processVertex27396(d_Vertex91214 d_v30678) {
	vec2 d_pixelPos73643;
	ivec2 d_rhs81108;
	vec2 d_rhs62465, d_result54197, tmp83299, d_result40927, tmp95896, tmp6847, d_rhs35678, d_result33327, tmp56015, d_rhs97810, d_result63957, d_v4728;
	vec4 d_position88813;
	d_rhs62465 = d_samples85755[uint(gl_InstanceID)].f0;
	d_result54197 = vec2(0.);
	d_result54197[0u] = (d_v30678.f0[0u] + d_rhs62465[0u]);
	d_result54197[1u] = (d_v30678.f0[1u] + d_rhs62465[1u]);
	d_pixelPos73643 = d_result54197;
	d_position88813 = vec4(0.);
	d_rhs81108 = d_TRect45085(tmp62909, tmp8797).f1;
	d_result40927 = vec2(0.);
	d_result40927[0u] = (d_pixelPos73643[0u] / float(d_rhs81108[0u]));
	d_result40927[1u] = (d_pixelPos73643[1u] / float(d_rhs81108[1u]));
	tmp83299 = d_result40927;
	tmp95896 = vec2(0., 0.);
	tmp95896[0u] = 2.;
	tmp95896[1u] = -2.;
	d_rhs35678 = tmp95896;
	d_result33327 = vec2(0.);
	d_result33327[0u] = (tmp83299[0u] * d_rhs35678[0u]);
	d_result33327[1u] = (tmp83299[1u] * d_rhs35678[1u]);
	tmp6847 = d_result33327;
	tmp56015 = vec2(0., 0.);
	tmp56015[0u] = -1.;
	tmp56015[1u] = 1.;
	d_rhs97810 = tmp56015;
	d_result63957 = vec2(0.);
	d_result63957[0u] = (tmp6847[0u] + d_rhs97810[0u]);
	d_result63957[1u] = (tmp6847[1u] + d_rhs97810[1u]);
	d_v4728 = d_result63957;
	d_position88813[0u] = d_v4728[0u];
	d_position88813[1u] = d_v4728[1u];
	d_position88813[2u] = 0.;
	d_position88813[3u] = 1.;
	d_uv11771 = d_v30678.f1;
	return d_VSOutput49174(d_position88813);
}
flat out int tmp78445;
in vec2 tmp93363;
in vec2 tmp78650;
void main() {
	d_Vertex91214 tmp6572;
	d_samples85755 = tmp88252;
	tmp78445 = gl_InstanceID;
	tmp6572.f0 = tmp93363;
	tmp6572.f1 = tmp78650;
	gl_Position = d_processVertex27396(tmp6572).f0;
	tmp17761 = d_uv11771;
}
";
	enum FragmentSource = "struct d_Sample3899 {
	vec2 f0;
	int f1;
};
uniform d_Sample3899[12] tmp88252;
d_Sample3899[12] d_samples85755;
in vec2 tmp17761;
vec2 d_uv11771;
out ivec4 tmp63823;
ivec4 d_fragColor11555;
flat in int tmp78445;
void d_processFragment90209() {
	float d_v47538;
	ivec4 tmp87383;
	d_v47538 = ((d_uv11771[0u] / 2.) + d_uv11771[1u]);
	if (((d_v47538 * d_v47538) > d_uv11771[1u])) {
		discard;
	}
	tmp87383 = ivec4(0, 0, 0, 0);
	tmp87383[0u] = d_samples85755[uint(tmp78445)].f1;
	tmp87383[1u] = 0;
	tmp87383[2u] = 0;
	tmp87383[3u] = 0;
	d_fragColor11555 = tmp87383;
}
void main() {
	d_uv11771 = tmp17761;
	d_samples85755 = tmp88252;
	d_processFragment90209();
	tmp63823 = d_fragColor11555;
}
";
	template Rename(string name) if (name == "fragColor") { enum Rename = "tmp63823"; }
	template Rename(string name) if (name == "uv") { enum Rename = "tmp17761"; }
	template Rename(string name) if (name == "samples") { enum Rename = "tmp88252"; }
}
struct C2gd8graphics7context10ShaderBlit {
	enum VertexSource = "struct d_Vertex91214 {
	vec2 f0;
	vec2 f1;
};
struct d_VSOutput49174 {
	vec4 f0;
};
out vec2 tmp55863;
vec2 d_uv70020;
d_VSOutput49174 d_processVertex89037(d_Vertex91214 d_v26889) {
	vec4 d_position96216;
	vec2 d_v77197, tmp768, tmp25604, d_rhs93218, d_result12211, d_rhs99307, d_result48745;
	d_position96216 = vec4(0.);
	d_v77197 = d_v26889.f0;
	d_position96216[0u] = d_v77197[0u];
	d_position96216[1u] = d_v77197[1u];
	d_position96216[2u] = 0.;
	d_position96216[3u] = 1.;
	tmp768 = vec2(0., 0.);
	tmp768[0u] = 0.;
	tmp768[1u] = 1.;
	tmp25604 = vec2(0., 0.);
	tmp25604[0u] = 1.;
	tmp25604[1u] = -1.;
	d_rhs93218 = d_v26889.f1;
	d_result12211 = vec2(0.);
	d_result12211[0u] = (tmp25604[0u] * d_rhs93218[0u]);
	d_result12211[1u] = (tmp25604[1u] * d_rhs93218[1u]);
	d_rhs99307 = d_result12211;
	d_result48745 = vec2(0.);
	d_result48745[0u] = (tmp768[0u] + d_rhs99307[0u]);
	d_result48745[1u] = (tmp768[1u] + d_rhs99307[1u]);
	d_uv70020 = d_result48745;
	return d_VSOutput49174(d_position96216);
}
flat out int tmp78445;
in vec2 tmp85732;
in vec2 tmp30924;
void main() {
	d_Vertex91214 tmp2491;
	tmp78445 = gl_InstanceID;
	tmp2491.f0 = tmp85732;
	tmp2491.f1 = tmp30924;
	gl_Position = d_processVertex89037(tmp2491).f0;
	tmp55863 = d_uv70020;
}
";
	enum FragmentSource = "uniform sampler2D d_source37779;
in vec2 tmp55863;
vec2 d_uv70020;
out vec4 tmp86368;
vec4 d_fragColor98915;
void d_processFragment80397() {
	d_fragColor98915 = texture(d_source37779, d_uv70020);
}
void main() {
	d_uv70020 = tmp55863;
	d_processFragment80397();
	tmp86368 = d_fragColor98915;
}
";
	template Rename(string name) if (name == "fragColor") { enum Rename = "tmp86368"; }
	template Rename(string name) if (name == "source") { enum Rename = "d_source37779"; }
	template Rename(string name) if (name == "uv") { enum Rename = "tmp55863"; }
}
struct C2gd8graphics7context18ShaderSubpixelBlit {
	enum VertexSource = "struct d_Vertex91214 {
	vec2 f0;
	vec2 f1;
};
struct d_VSOutput49174 {
	vec4 f0;
};
uniform ivec2 tmp99279;
ivec2 d_sampledSize74469;
uniform vec4 tmp15006;
vec4 d_color48754;
uniform float tmp91710;
float d_contrastFactor45580;
uniform int tmp66838;
int d_antialias65631;
out vec2 tmp92947;
vec2 d_uv4324;
d_VSOutput49174 d_processVertex98010(d_Vertex91214 d_v81804) {
	vec4 d_position5268;
	vec2 d_v74516;
	d_position5268 = vec4(0.);
	d_v74516 = d_v81804.f0;
	d_position5268[0u] = d_v74516[0u];
	d_position5268[1u] = d_v74516[1u];
	d_position5268[2u] = 0.;
	d_position5268[3u] = 1.;
	d_uv4324 = d_v81804.f1;
	return d_VSOutput49174(d_position5268);
}
flat out int tmp78445;
in vec2 tmp72958;
in vec2 tmp11262;
void main() {
	d_Vertex91214 tmp37200;
	d_antialias65631 = tmp66838;
	d_contrastFactor45580 = tmp91710;
	d_color48754 = tmp15006;
	d_sampledSize74469 = tmp99279;
	tmp78445 = gl_InstanceID;
	tmp37200.f0 = tmp72958;
	tmp37200.f1 = tmp11262;
	gl_Position = d_processVertex98010(tmp37200).f0;
	tmp92947 = d_uv4324;
}
";
	enum FragmentSource = "struct d_TRect45085 {
	ivec2 f0;
	ivec2 f1;
};
uniform sampler2D d_target10688;
uniform usampler2D d_sampled60415;
uniform ivec2 tmp99279;
ivec2 d_sampledSize74469;
uniform vec4 tmp15006;
vec4 d_color48754;
uniform float tmp91710;
float d_contrastFactor45580;
uniform int tmp66838;
int d_antialias65631;
in vec2 tmp92947;
vec2 d_uv4324;
out vec4 tmp82035;
vec4 d_fragColor32796;
uniform ivec2 tmp62909;
uniform ivec2 tmp8797;
void d_processFragment83566() {
	vec2 d_transformedUV69669;
	float tmp54435, d_res54986, tmp53795, d_res27727, d_res20115, tmp77650, d_res65541, tmp77742, d_res61516, d_res97454, d_s127724, d_s299450, d_s33661, d_sr49747, d_alpha94078, d_sg58412, d_alpha46936, d_sb35223, d_alpha9909, d_alpha37428, d_alpha52805, d_alpha7699, d_alpha88268, d_alpha4387, d_alpha62420, d_alpha24143, d_alpha57726, d_alpha19152, d_alpha30558, d_alpha53325;
	int d_i23501;
	ivec2 d_base65117, d_rhs1663;
	ivec4 d_sampleR19477, d_sampleL7635;
	uint d_v87619, d_i2278, d_i60453, d_i17688, d_v43120, d_i71327, d_i62684, d_i19556;
	uvec4 d_base22121, d_base68510;
	vec2 tmp9247, tmp28657, tmp87577, d_rhs4429, d_result49051, tmp5284, d_result10864, d_rhs65844, d_result22906, d_rhs70823, d_result36858, tmp49154, tmp27599, d_rhs9561, d_result45494, d_rhs61803, d_result81520, tmp37193, d_rhs17374, d_result74964;
	vec3 d_sampleLP96979, tmp71133, d_sampleRP52110, tmp94316;
	vec4 d_targetColor64774, tmp85669, tmp73113, tmp18147;
	tmp9247 = vec2(0., 0.);
	tmp9247[0u] = 0.;
	tmp9247[1u] = 1.;
	tmp28657 = vec2(0., 0.);
	tmp28657[0u] = 1.;
	tmp28657[1u] = -1.;
	d_rhs4429 = d_uv4324;
	d_result49051 = vec2(0.);
	d_result49051[0u] = (tmp28657[0u] * d_rhs4429[0u]);
	d_result49051[1u] = (tmp28657[1u] * d_rhs4429[1u]);
	tmp87577 = d_result49051;
	tmp5284 = vec2(0., 0.);
	d_base65117 = d_TRect45085(tmp62909, tmp8797).f1;
	tmp5284[0u] = float(d_base65117[0u]);
	tmp5284[1u] = float(d_base65117[1u]);
	d_rhs1663 = d_sampledSize74469;
	d_result10864 = vec2(0.);
	d_result10864[0u] = (tmp5284[0u] / float(d_rhs1663[0u]));
	d_result10864[1u] = (tmp5284[1u] / float(d_rhs1663[1u]));
	d_rhs65844 = d_result10864;
	d_result22906 = vec2(0.);
	d_result22906[0u] = (tmp87577[0u] * d_rhs65844[0u]);
	d_result22906[1u] = (tmp87577[1u] * d_rhs65844[1u]);
	d_rhs70823 = d_result22906;
	d_result36858 = vec2(0.);
	d_result36858[0u] = (tmp9247[0u] + d_rhs70823[0u]);
	d_result36858[1u] = (tmp9247[1u] + d_rhs70823[1u]);
	d_transformedUV69669 = d_result36858;
	d_sampleR19477 = ivec4(0);
	d_base22121 = texture(d_sampled60415, d_transformedUV69669);
	d_sampleR19477[0u] = int(d_base22121[0u]);
	d_sampleR19477[1u] = int(d_base22121[1u]);
	d_sampleR19477[2u] = int(d_base22121[2u]);
	d_sampleR19477[3u] = int(d_base22121[3u]);
	tmp49154 = vec2(0., 0.);
	tmp49154[0u] = 0.;
	tmp49154[1u] = 1.;
	tmp27599 = vec2(0., 0.);
	tmp27599[0u] = 1.;
	tmp27599[1u] = -1.;
	d_rhs9561 = d_uv4324;
	d_result45494 = vec2(0.);
	d_result45494[0u] = (tmp27599[0u] * d_rhs9561[0u]);
	d_result45494[1u] = (tmp27599[1u] * d_rhs9561[1u]);
	d_rhs61803 = d_result45494;
	d_result81520 = vec2(0.);
	d_result81520[0u] = (tmp49154[0u] + d_rhs61803[0u]);
	d_result81520[1u] = (tmp49154[1u] + d_rhs61803[1u]);
	d_targetColor64774 = texture(d_target10688, d_result81520);
	if ((d_antialias65631 == 2)) {
		d_sampleL7635 = ivec4(0);
		tmp37193 = vec2(0., 0.);
		tmp37193[0u] = (1. / float(d_sampledSize74469[0u]));
		tmp37193[1u] = 0.;
		d_rhs17374 = tmp37193;
		d_result74964 = vec2(0.);
		d_result74964[0u] = (d_transformedUV69669[0u] - d_rhs17374[0u]);
		d_result74964[1u] = (d_transformedUV69669[1u] - d_rhs17374[1u]);
		d_base68510 = texture(d_sampled60415, d_result74964);
		d_sampleL7635[0u] = int(d_base68510[0u]);
		d_sampleL7635[1u] = int(d_base68510[1u]);
		d_sampleL7635[2u] = int(d_base68510[2u]);
		d_sampleL7635[3u] = int(d_base68510[3u]);
		d_v87619 = uint(d_sampleL7635[0u]);
		tmp71133 = vec3(0., 0., 0.);
		d_i2278 = (d_v87619 >> 0);
		d_res54986 = 0.;
		if (bool((d_i2278 & 1u))) {
			d_res54986 = (d_res54986 += 0.25);
		}
		if (bool((d_i2278 & 2u))) {
			d_res54986 = (d_res54986 += 0.25);
		}
		if (bool((d_i2278 & 4u))) {
			d_res54986 = (d_res54986 += 0.25);
		}
		if (bool((d_i2278 & 8u))) {
			d_res54986 = (d_res54986 += 0.25);
		}
		tmp54435 = d_res54986;
		d_i60453 = (d_v87619 >> 4);
		d_res27727 = 0.;
		if (bool((d_i60453 & 1u))) {
			d_res27727 = (d_res27727 += 0.25);
		}
		if (bool((d_i60453 & 2u))) {
			d_res27727 = (d_res27727 += 0.25);
		}
		if (bool((d_i60453 & 4u))) {
			d_res27727 = (d_res27727 += 0.25);
		}
		if (bool((d_i60453 & 8u))) {
			d_res27727 = (d_res27727 += 0.25);
		}
		tmp53795 = d_res27727;
		d_i17688 = (d_v87619 >> 8);
		d_res20115 = 0.;
		if (bool((d_i17688 & 1u))) {
			d_res20115 = (d_res20115 += 0.25);
		}
		if (bool((d_i17688 & 2u))) {
			d_res20115 = (d_res20115 += 0.25);
		}
		if (bool((d_i17688 & 4u))) {
			d_res20115 = (d_res20115 += 0.25);
		}
		if (bool((d_i17688 & 8u))) {
			d_res20115 = (d_res20115 += 0.25);
		}
		tmp71133[0u] = tmp54435;
		tmp71133[1u] = tmp53795;
		tmp71133[2u] = d_res20115;
		d_sampleLP96979 = tmp71133;
		d_v43120 = uint(d_sampleR19477[0u]);
		tmp94316 = vec3(0., 0., 0.);
		d_i71327 = (d_v43120 >> 0);
		d_res65541 = 0.;
		if (bool((d_i71327 & 1u))) {
			d_res65541 = (d_res65541 += 0.25);
		}
		if (bool((d_i71327 & 2u))) {
			d_res65541 = (d_res65541 += 0.25);
		}
		if (bool((d_i71327 & 4u))) {
			d_res65541 = (d_res65541 += 0.25);
		}
		if (bool((d_i71327 & 8u))) {
			d_res65541 = (d_res65541 += 0.25);
		}
		tmp77650 = d_res65541;
		d_i62684 = (d_v43120 >> 4);
		d_res61516 = 0.;
		if (bool((d_i62684 & 1u))) {
			d_res61516 = (d_res61516 += 0.25);
		}
		if (bool((d_i62684 & 2u))) {
			d_res61516 = (d_res61516 += 0.25);
		}
		if (bool((d_i62684 & 4u))) {
			d_res61516 = (d_res61516 += 0.25);
		}
		if (bool((d_i62684 & 8u))) {
			d_res61516 = (d_res61516 += 0.25);
		}
		tmp77742 = d_res61516;
		d_i19556 = (d_v43120 >> 8);
		d_res97454 = 0.;
		if (bool((d_i19556 & 1u))) {
			d_res97454 = (d_res97454 += 0.25);
		}
		if (bool((d_i19556 & 2u))) {
			d_res97454 = (d_res97454 += 0.25);
		}
		if (bool((d_i19556 & 4u))) {
			d_res97454 = (d_res97454 += 0.25);
		}
		if (bool((d_i19556 & 8u))) {
			d_res97454 = (d_res97454 += 0.25);
		}
		tmp94316[0u] = tmp77650;
		tmp94316[1u] = tmp77742;
		tmp94316[2u] = d_res97454;
		d_sampleRP52110 = tmp94316;
		d_s127724 = d_sampleLP96979[0u];
		d_s299450 = d_sampleRP52110[1u];
		d_s33661 = d_sampleRP52110[2u];
		d_alpha94078 = d_contrastFactor45580;
		d_sr49747 = ((d_s127724 * (1. - d_alpha94078)) + ((((d_sampleLP96979[2u] + d_s127724) + d_s299450) / 3.) * d_alpha94078));
		d_alpha46936 = d_contrastFactor45580;
		d_sg58412 = ((d_s299450 * (1. - d_alpha46936)) + ((((d_s127724 + d_s299450) + d_s33661) / 3.) * d_alpha46936));
		d_alpha9909 = d_contrastFactor45580;
		d_sb35223 = ((d_s33661 * (1. - d_alpha9909)) + ((((d_s299450 + d_s33661) + d_sampleRP52110[0u]) / 3.) * d_alpha9909));
		tmp85669 = vec4(0., 0., 0., 0.);
		d_alpha37428 = (d_sr49747 * d_color48754[3u]);
		d_alpha52805 = (d_sg58412 * d_color48754[3u]);
		d_alpha7699 = (d_sb35223 * d_color48754[3u]);
		tmp85669[0u] = ((d_targetColor64774[0u] * (1. - d_alpha37428)) + (d_color48754[0u] * d_alpha37428));
		tmp85669[1u] = ((d_targetColor64774[1u] * (1. - d_alpha52805)) + (d_color48754[1u] * d_alpha52805));
		tmp85669[2u] = ((d_targetColor64774[2u] * (1. - d_alpha7699)) + (d_color48754[2u] * d_alpha7699));
		tmp85669[3u] = 1.;
		d_fragColor32796 = tmp85669;
	}
	else {
		if ((d_antialias65631 == 1)) {
			d_alpha88268 = float(d_sampleR19477[0u]);
			tmp73113 = vec4(0., 0., 0., 0.);
			d_alpha4387 = (d_alpha88268 * d_color48754[3u]);
			d_alpha62420 = (d_alpha88268 * d_color48754[3u]);
			d_alpha24143 = (d_alpha88268 * d_color48754[3u]);
			tmp73113[0u] = ((d_targetColor64774[0u] * (1. - d_alpha4387)) + (d_color48754[0u] * d_alpha4387));
			tmp73113[1u] = ((d_targetColor64774[1u] * (1. - d_alpha62420)) + (d_color48754[1u] * d_alpha62420));
			tmp73113[2u] = ((d_targetColor64774[2u] * (1. - d_alpha24143)) + (d_color48754[2u] * d_alpha24143));
			tmp73113[3u] = 1.;
			d_fragColor32796 = tmp73113;
		}
		else {
			d_i23501 = d_sampleR19477[0u];
			d_alpha57726 = 0.;
			if (bool((d_i23501 & 1))) {
				d_alpha57726 = (d_alpha57726 += 0.125);
			}
			if (bool((d_i23501 & 2))) {
				d_alpha57726 = (d_alpha57726 += 0.125);
			}
			if (bool((d_i23501 & 4))) {
				d_alpha57726 = (d_alpha57726 += 0.125);
			}
			if (bool((d_i23501 & 8))) {
				d_alpha57726 = (d_alpha57726 += 0.125);
			}
			if (bool((d_i23501 & 16))) {
				d_alpha57726 = (d_alpha57726 += 0.125);
			}
			if (bool((d_i23501 & 32))) {
				d_alpha57726 = (d_alpha57726 += 0.125);
			}
			if (bool((d_i23501 & 64))) {
				d_alpha57726 = (d_alpha57726 += 0.125);
			}
			if (bool((d_i23501 & 128))) {
				d_alpha57726 = (d_alpha57726 += 0.125);
			}
			tmp18147 = vec4(0., 0., 0., 0.);
			d_alpha19152 = (d_alpha57726 * d_color48754[3u]);
			d_alpha30558 = (d_alpha57726 * d_color48754[3u]);
			d_alpha53325 = (d_alpha57726 * d_color48754[3u]);
			tmp18147[0u] = ((d_targetColor64774[0u] * (1. - d_alpha19152)) + (d_color48754[0u] * d_alpha19152));
			tmp18147[1u] = ((d_targetColor64774[1u] * (1. - d_alpha30558)) + (d_color48754[1u] * d_alpha30558));
			tmp18147[2u] = ((d_targetColor64774[2u] * (1. - d_alpha53325)) + (d_color48754[2u] * d_alpha53325));
			tmp18147[3u] = 1.;
			d_fragColor32796 = tmp18147;
		}
	}
}
void main() {
	d_uv4324 = tmp92947;
	d_antialias65631 = tmp66838;
	d_contrastFactor45580 = tmp91710;
	d_color48754 = tmp15006;
	d_sampledSize74469 = tmp99279;
	d_processFragment83566();
	tmp82035 = d_fragColor32796;
}
";
	template Rename(string name) if (name == "fragColor") { enum Rename = "tmp82035"; }
	template Rename(string name) if (name == "uv") { enum Rename = "tmp92947"; }
	template Rename(string name) if (name == "contrastFactor") { enum Rename = "tmp91710"; }
	template Rename(string name) if (name == "color") { enum Rename = "tmp15006"; }
	template Rename(string name) if (name == "antialias") { enum Rename = "tmp66838"; }
	template Rename(string name) if (name == "sampled") { enum Rename = "d_sampled60415"; }
	template Rename(string name) if (name == "target") { enum Rename = "d_target10688"; }
	template Rename(string name) if (name == "sampledSize") { enum Rename = "tmp99279"; }
}
