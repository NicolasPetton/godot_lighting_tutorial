shader_type canvas_item;

uniform vec4 modulate_color : source_color = vec4(0.0);
uniform vec4 black_point : source_color = vec4(0.0);
uniform vec2 lights[100];
uniform int number_of_lights = 1;
uniform float band_1_radius = 54;
uniform float band_2_radius = 38;
uniform float band_1_strength = 0.3;
uniform float band_2_strength = 0.6;
uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;
uniform float light_radius = 64.0;

float distance_to_light(vec2 coords) {
	float dist = 1000.0;
	
	for (int i = 0; i < number_of_lights; i++) {
		float new_dist = distance(coords, lights[i]);
		
		if (new_dist < dist) {
			dist = new_dist;
		}
	}
	
	return dist;
}

vec4 set_black_point(vec4 color) {
	float bp_avg = black_point.r + black_point.g + black_point.b;
	float color_avg = color.r + color.g + color.b;
	
	if (color_avg < bp_avg) {
		return black_point;
	} else {
		return color;
	}
}

vec4 modulate(vec4 color, float distance_to_light) {
	vec4 modulated = color * modulate_color;
	
	if (distance_to_light > light_radius) {
		return modulated;
	}
	
	if (distance_to_light > band_1_radius) {
		return mix(modulated, color, band_1_strength);
	}
	
	if (distance_to_light > band_2_radius) {
		return mix(modulated, color, band_2_strength);
	}
	
	return color;
}

void fragment() {
	COLOR = texture(screen_texture, SCREEN_UV);
	COLOR = modulate(COLOR, distance_to_light(FRAGCOORD.xy));
	COLOR = set_black_point(COLOR);
	
	
}