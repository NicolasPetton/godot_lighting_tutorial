extends CharacterBody2D
class_name Character

@export var speed := 60.0

var direction := Vector2.ZERO

func _ready():
	$AnimationTree.active = true

func _physics_process(delta):
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	
	velocity = direction * speed
	move_and_slide()
	
	if direction != Vector2.ZERO:
		$AnimationTree["parameters/Idle/blend_position"] = direction
		$AnimationTree["parameters/Walk/blend_position"] = direction
		$AnimationTree["parameters/playback"].travel("Walk")
	else:
		$AnimationTree["parameters/playback"].travel("Idle")

func get_mirrored_frame():
	var frame = $Sprite2D.frame
	
	if frame < 4 or frame > 7 and frame < 12:
		return frame + 4
		
	return frame - 4
