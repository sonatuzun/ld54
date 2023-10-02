extends CanvasItem

var _shaderMaterial : ShaderMaterial
const SINGLE_FLASH_DURATION = 0.05

# Called when the node enters the scene tree for the first time.
func _ready():
	material = material.duplicate()
	_shaderMaterial = material
	pass # Replace with function body.

func flash():
	_shaderMaterial.set_shader_parameter("isEnabled", true);
	_shaderMaterial.set_shader_parameter("paintColor", Color.DARK_RED);
	await get_tree().create_timer(SINGLE_FLASH_DURATION).timeout
	_shaderMaterial.set_shader_parameter("paintColor", Color.BLACK);
	await get_tree().create_timer(SINGLE_FLASH_DURATION).timeout
	_shaderMaterial.set_shader_parameter("paintColor", Color.DARK_RED);
	await get_tree().create_timer(SINGLE_FLASH_DURATION).timeout
	_shaderMaterial.set_shader_parameter("isEnabled", false);
	pass
