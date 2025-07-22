class_name Player
extends CharacterBody2D

@export_group("Components")
@export var movement_component: MovementComponent

func _physics_process(_delta: float) -> void:
	movement_component.move()
