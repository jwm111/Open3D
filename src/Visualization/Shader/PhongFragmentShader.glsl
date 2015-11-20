#version 120

varying vec3 vertex_position_world;
varying vec3 vertex_normal_camera;
varying vec3 eye_dir_camera;
varying mat4 light_dir_camera_4;
varying vec3 fragment_color;

uniform mat4 light_color_4;
uniform vec4 light_power_4;

void main()
{
	vec3 diffuse_color = fragment_color;
	vec3 ambient_color = vec3(0.1, 0.1, 0.1) * diffuse_color;
	vec3 specular_color = vec3(0.8, 0.8, 0.8);
	vec4 cos_theta;
	vec4 cos_alpha;
	vec3 n, e, l, r;

	n = normalize(vertex_normal_camera);
	e = normalize(eye_dir_camera);
	l = normalize(light_dir_camera_4[0].xyz);
	r = reflect(-l, n);
	cos_theta[0] = clamp(dot(n, l), 0, 1);
	cos_alpha[0] = clamp(dot(e, r), 0, 1);

	l= normalize(light_dir_camera_4[1].xyz);
	r = reflect(-l, n);
	cos_theta[1] = clamp(dot(n, l), 0, 1);
	cos_alpha[1] = clamp(dot(e, r), 0, 1);

	l= normalize(light_dir_camera_4[2].xyz);
	r = reflect(-l, n);
	cos_theta[2] = clamp(dot(n, l), 0, 1);
	cos_alpha[2] = clamp(dot(e, r), 0, 1);

	l= normalize(light_dir_camera_4[3].xyz);
	r = reflect(-l, n);
	cos_theta[3] = clamp(dot(n, l), 0, 1);
	cos_alpha[3] = clamp(dot(e, r), 0, 1);

	gl_FragColor.rgb = ambient_color + 
			diffuse_color * light_color_4[0].xyz * light_power_4[0] * cos_theta[0] +
			specular_color * light_color_4[0].xyz * light_power_4[0] * pow(cos_alpha[0], 5) +
			diffuse_color * light_color_4[1].xyz * light_power_4[1] * cos_theta[1] +
			specular_color * light_color_4[1].xyz * light_power_4[1] * pow(cos_alpha[1], 5) +
			diffuse_color * light_color_4[2].xyz * light_power_4[2] * cos_theta[2] +
			specular_color * light_color_4[2].xyz * light_power_4[2] * pow(cos_alpha[2], 5) +
			diffuse_color * light_color_4[3].xyz * light_power_4[3] * cos_theta[3] +
			specular_color * light_color_4[3].xyz * light_power_4[3] * pow(cos_alpha[3], 5);
}
