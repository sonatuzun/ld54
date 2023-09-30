shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

uniform float brightness = 1.0;
uniform float contrast = 2.0;
uniform float saturation = 1.0;

void fragment() {
    vec3 c = textureLod(screen_texture, SCREEN_UV, 0.0).rgb;

    c.rgb = mix(vec3(0.0), c.rgb, brightness);
    c.rgb = mix(vec3(0.5), c.rgb, contrast);
    c.rgb = mix(vec3(dot(vec3(1.0), c.rgb) * 0.33333), c.rgb, saturation);
	
	vec2 diffFromCenter = SCREEN_UV - vec2(0.8,0.5);
	float lenFromCenter = length(diffFromCenter);
	float darkness = pow(lenFromCenter, 0.2f) * ( 0.2f + 0.2f * sin(TIME) );
	c.rgb = mix(c.rgb, vec3(0,0,0), darkness);

    COLOR.rgb = c;
}