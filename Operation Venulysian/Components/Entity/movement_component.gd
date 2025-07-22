class_name MovementComponent
extends Node

@export var character_body: CharacterBody2D
@export var speed: float = 400

var is_jumping: bool = false

## Gets the input and call the CharacterBody's move and slide method
func move() -> void:
	var direction: Vector2
	#var direction: Vector2 = Input.get_vector("Left", "Right", "Up", "Down").normalized()
	
	if Input.is_action_pressed("Left"):
		direction.x = -1
	if Input.is_action_pressed("Right"):
		direction.x = 1
	
	character_body.velocity = direction * speed
	
	#region movement alternative
	
	# this makes quick strafing not possible, as pressing both Left and Right keys will cancel the movement
	
	#if Input.is_action_pressed("Left"):
		#direction.x += -1
	#if Input.is_action_pressed("Right"):
		#direction.x += 1
		
	#character_body.velocity = direction.normalized() * speed
	
	#endregion
	
	if !is_jumping:
		character_body.velocity.y += 500
	
	character_body.move_and_slide()
