class_name GrapplingPoint
extends Node2D

@export var interaction_area: Area2D
@export var destination_point: Marker2D

var player: Player

func _process(delta: float) -> void:
	pass
	#print(PlayerVars.is_in_grappling_range)

func _on_interaction_area_body_entered(body: Node2D) -> void:
	player = body
	
	player.update_grappling_hook_position(destination_point.global_position)
	PlayerVars.is_in_grappling_range = true

func _on_interaction_area_body_exited(body: Node2D) -> void:
	PlayerVars.is_in_grappling_range = false
