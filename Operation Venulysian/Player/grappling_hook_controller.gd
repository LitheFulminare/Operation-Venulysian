class_name GrapplingHookController
extends Node

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Grappling Hook"):
		use_grappling_hook()

func use_grappling_hook():
	if PlayerVars.is_in_grappling_range:
		print("Player used grappling hook in range")
	else:
		print("Player used grappling hook outside of range")
