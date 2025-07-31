class_name GrapplingHookComponent
extends Node

var current_grappling_hook_position: Vector2

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Grappling Hook"):
		use_grappling_hook()

func use_grappling_hook():
	if PlayerVars.is_in_grappling_range:
		print("Player destination: " + str(current_grappling_hook_position))
	else:
		print("Player used grappling hook outside of range")
