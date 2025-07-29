class_name MovementComponent
extends Node

@export_group("Components")
@export var character_body: CharacterBody2D

@export_group("Parameters")
@export var walk_speed: float = 300
@export var jump_velocity: float = 400
@export_range(0, 1) var jump_release_deceleration = 0.5

var is_dashing: bool = false

func move(delta: float) -> void:
	if !character_body.is_on_floor():
		character_body.velocity += character_body.get_gravity() * delta

	if Input.is_action_just_pressed("Up") && character_body.is_on_floor():
		character_body.velocity.y = -jump_velocity

	if Input.is_action_just_released("Up"):
		character_body.velocity.y *= jump_release_deceleration
		
	if PlayerVars.dash_unlocked && Input.is_action_just_pressed("Dash"):
		print("player dashed")
		
	var direction := Input.get_axis("Left", "Right")
	if direction:
		character_body.velocity.x = direction * walk_speed
	else:
		character_body.velocity.x = move_toward(character_body.velocity.x, 0, walk_speed)

	character_body.move_and_slide()
