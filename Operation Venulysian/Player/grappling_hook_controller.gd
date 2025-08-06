class_name GrapplingHookComponent
extends Node

@export_group("Components")
@export var player: Player
@export var path_2d: Path2D
@export var path_follow_2d: PathFollow2D
@export var line2d: Line2D

@export_group("Parameters")
@export var player_speed: float = 500

var current_grappling_point: GrapplingPoint

func _ready() -> void:
	line2d.visible = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Grappling Hook"):
		use_grappling_hook()

func use_grappling_hook() -> void:
	if PlayerVars.is_in_grappling_range:
		print("Player destination: " + str(current_grappling_point.destination_point))
		path_2d.curve.set_point_position(0, player.global_position)
		path_2d.curve.set_point_position(1, current_grappling_point.destination_point.global_position)
		player.is_in_grappling_hook = true
		line2d.set_point_position(0, current_grappling_point.global_position)
		line2d.visible = true
	else:
		print("Player used grappling hook outside of range")

func move_player(delta: float) -> void:
	if path_follow_2d.progress_ratio < 1:
		path_follow_2d.progress_ratio += player_speed  * delta
		player.global_position = path_follow_2d.global_position
		line2d.global_position = Vector2.ZERO
		line2d.set_point_position(1, player.global_position)
		print(line2d.get_point_position(1))
	else:
		print("Player landed")
		line2d.visible = false
		path_follow_2d.progress_ratio = 0
		player.is_in_grappling_hook = false
