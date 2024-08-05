#version 460 core

in vec2 TexCoord;

layout(location = 0) out vec4 FragColor;

uniform sampler2D texture0;
uniform float stepAngle;
uniform int quality;
uniform vec2 resolution;
uniform vec2 pivot;
uniform float rPos;

mat2 rot_mat(float angle) { return mat2(cos(angle), -sin(angle), sin(angle), cos(angle)); }

void main() {
    vec4 color = vec4(0);
	mat2 rot1 = rot_mat(stepAngle);
	mat2 rot2 = rot_mat(-stepAngle);
	vec2 uv1 = (TexCoord * resolution - pivot) * rot_mat(rPos);
	vec2 uv2 = uv1;

	for(int i = 1; i <= quality; i++){
		uv1 *= rot1;
		color += texture(texture0, clamp((uv1 + pivot) / resolution, 0, 1));
		
		uv2 *= rot2;
		color += texture(texture0, clamp((uv2 + pivot) / resolution, 0, 1));
	}
    FragColor = color / (quality * 2);
}
