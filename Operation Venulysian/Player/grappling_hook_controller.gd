class_name GrapplingHookComponent
extends Node

@export_group("Components")
@export var player: Player
@export var path_2d: Path2D
@export var path_follow_2d: PathFollow2D

@export_group("Parameters")
@export var player_speed: float = 500

var current_grappling_hook_position: Vector2

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Grappling Hook"):
		use_grappling_hook()

func use_grappling_hook() -> void:
	if PlayerVars.is_in_grappling_range:
		print("Player destination: " + str(current_grappling_hook_position))
		path_2d.curve.set_point_position(0, player.global_position)
		path_2d.curve.set_point_position(1, current_grappling_hook_position)
		player.is_in_grappling_hook = true
	else:
		print("Player used grappling hook outside of range")

func move_player(delta: float) -> void:
	if path_follow_2d.progress_ratio < 1:
		path_follow_2d.progress_ratio += player_speed  * delta
		player.global_position = path_follow_2d.global_position
	else:
		print("Player landed")
		path_follow_2d.progress_ratio = 0
		player.is_in_grappling_hook = false
