extends Node2D
class_name Mirror

@export var character: Node
@export var offset := Vector2.ZERO
@export var opacity_factor := 0.02

func _process(_delta):
	var distance_y = character.global_position.y - global_position.y

	_update_reflection_position(distance_y)
	_update_reflection_opacity(distance_y)
	_update_reflection_frame()

func _update_reflection_position(distance_y):
	$Reflection.global_position = Vector2(
		character.global_position.x,
		global_position.y - distance_y
	) + offset

func _update_reflection_frame():
	$Reflection.frame = character.get_mirrored_frame()

func _update_reflection_opacity(distance_y):
	$Reflection.modulate.a = 1.0 - distance_y * opacity_factor
