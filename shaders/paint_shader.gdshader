shader_type canvas_item;

uniform bool isEnabled = false;
uniform vec4 paintColor : source_color =  vec4(1.0f);

void fragment() {
	vec4 textureColor = texture(TEXTURE, UV);
	if (isEnabled && textureColor.a > 0.1f) 
	{
		COLOR = paintColor;
	}
	else
	{
		COLOR = textureColor;
	}
}
