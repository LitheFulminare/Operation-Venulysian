class_name Player
extends CharacterBody2D

@export_group("Components")
@export var movement_component: MovementComponent

var is_movement_blocked: bool = false

func _physics_process(delta: float) -> void:
	movement_component.move(delta)

func block_movement() -> void:
	is_movement_blocked = true
	
func unblock_movement() -> void:
	is_movement_blocked = false
