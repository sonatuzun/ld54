shader_type canvas_item;

uniform float tile_factor = 10.0;
uniform float aspect_ratio = 0.5;

uniform sampler2D texture_offset_uv;
uniform vec2 texture_offset_scale = vec2(0.2, 0.2);
uniform float texture_offset_height = 0.1;

uniform float texture_offset_time_scale = 0.05;

uniform float sine_time_scale = 0.03;
uniform vec2 sine_offset_scale = vec2(0.4, 0.4);
uniform float sine_wave_size = 0.4;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

vec2 calculate_sine_wave(vec2 uv) {
	return vec2(
		-10000.f,
		cos(0.1 * TIME) * 0.1
	);
}

void fragment() {
	// COLOR = vec4(SCREEN_UV.x, SCREEN_UV.y, 1.0f, 1.0f);
	float ratio = 0.010f;
	float baseRate = 10.0f;
	float uvx = sin(SCREEN_UV.x * baseRate + TIME) * ratio;
	float uvy = sin(SCREEN_UV.y * baseRate + TIME * 0.67) * ratio;
	COLOR = texture(screen_texture, SCREEN_UV + vec2(uvx, uvy)   );
}
