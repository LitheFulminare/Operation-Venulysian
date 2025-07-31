class_name GrapplingPoint
extends Node2D

@export var interaction_area: Area2D

var is_player_in_area: bool = false

func _process(delta: float) -> void:
	print(is_player_in_area)

func _on_interaction_area_body_entered(body: Node2D) -> void:
	is_player_in_area = true


func _on_interaction_area_body_exited(body: Node2D) -> void:
	is_player_in_area = false
