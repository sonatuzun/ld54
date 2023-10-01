shader_type canvas_item;

uniform float baseRate;

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
	float uvx = sin(SCREEN_UV.x * baseRate + TIME) * ratio;
	float uvy = sin(SCREEN_UV.y * baseRate + TIME * 0.67) * ratio;
	COLOR = texture(screen_texture, SCREEN_UV + vec2(uvx, uvy)   );
}
