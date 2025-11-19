class_name MovementComponent
extends Node

@export_group("Components")
@export var player: Player
@export var dash_duration_timer: Timer
@export var dash_cooldown_timer: Timer

@export_group("Parameters")
@export var walk_speed: float = 300
@export var dash_speed_multiplier: float = 5
@export var jump_velocity: float = 400
@export_range(0, 1) var jump_release_deceleration = 0.5

var is_dashing: bool = false
var is_dash_on_cooldown: bool = false

var double_jump_active:bool = false

@onready var base_walk_speed: float = walk_speed
@onready var dash_speed: float = walk_speed * dash_speed_multiplier

func move(delta: float) -> void:
	fall(delta)
	
	jump()
	
	dash()
	
	set_player_velocity(get_direction())
	
	player.move_and_slide()

func fall(delta: float) -> void:
	if !player.is_on_floor() && !is_dashing:
		player.velocity += player.get_gravity() * delta

func jump() -> void:
	if Input.is_action_just_pressed("Up"):
		if player.is_on_floor():
			player.velocity.y = -jump_velocity
			double_jump_active = true
		elif PlayerVars.double_jump_unlocked && double_jump_active:
			player.velocity.y = -jump_velocity
			double_jump_active = false
			
	elif Input.is_action_just_released("Up"):
		player.velocity.y *= jump_release_deceleration

func dash() -> void:
	if PlayerVars.dash_unlocked && Input.is_action_just_pressed("Dash") && !is_dash_on_cooldown:
		is_dashing = true
		is_dash_on_cooldown = true
		walk_speed = dash_speed
		dash_duration_timer.start()

func get_direction() -> float:
	if is_dashing:
		if player.is_looking_right:
			return 1
			
		return -1
			
	return Input.get_axis("Left", "Right")

func set_player_velocity(direction: float) -> void:
	if direction:
		player.velocity.x = direction * walk_speed
		player.is_looking_right = direction > 0
	else:
		if player.is_on_floor():
			player.grappling_hook_component.hovering = false
		if player.grappling_hook_component.hovering:
			player.velocity.x = move_toward(player.velocity.x, 0, player.grappling_hook_component.hovering_friction)
		else:
			player.velocity.x = move_toward(player.velocity.x, 0, walk_speed)

func _on_dash_duration_timeout() -> void:
	is_dashing = false
	walk_speed = base_walk_speed
	dash_cooldown_timer.start()


func _on_dash_cooldown_timeout() -> void:
	is_dash_on_cooldown = false
