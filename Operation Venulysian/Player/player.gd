class_name Player
extends CharacterBody2D

@export_group("Components")
@export var movement_component: MovementComponent
@export var grappling_hook_component: GrapplingHookComponent

var is_movement_blocked: bool = false

func _physics_process(delta: float) -> void:
	movement_component.move(delta)

func block_movement() -> void:
	is_movement_blocked = true
	
func unblock_movement() -> void:
	is_movement_blocked = false

func update_grappling_hook_position(destination: Vector2) -> void:
	grappling_hook_component.current_grappling_hook_position = destination
