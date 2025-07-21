class_name MovementComponent
extends Node

@export var character_body: CharacterBody2D
@export var speed: float = 400

## Gets the input and call the CharacterBody's move and slide method
func move() -> void:
	var input_direction: Vector2 = Input.get_vector("Left", "Right", "Up", "Down").normalized()
	character_body.velocity = input_direction * speed
	
	character_body.move_and_slide()
