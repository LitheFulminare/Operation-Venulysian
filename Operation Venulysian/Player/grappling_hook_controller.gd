class_name GrapplingHookComponent
extends Node2D

@export_group("Components")
@export var player: Player
@export var line2d: Line2D
@export var raycast: RayCast2D
@export var cooldown_timer: Timer

@export_group("Parameters")
@export var player_speed: float = 500
@export var grappling_speed: float = 40
@export var max_grappling_speed: float = 500
@export var hovering_friction: float = 10
@export var coolddown_duration: float = 3;

var raycast_collision_point: Vector2
var mouse_position: Vector2
var hovering: bool = false
var is_on_cooldown: bool
var grappling_hook_missed: bool

func _ready() -> void:
	cooldown_timer.wait_time = coolddown_duration
	line2d.visible = false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Grappling Hook"):
		if player.is_in_grappling_hook:
			stop_using_grappling_hook()
		elif !is_on_cooldown:
			use_grappling_hook()
	if Input.is_action_just_pressed("Up") && player.is_in_grappling_hook:
		stop_using_grappling_hook()

## Called once when the player presses Grappling Hook button
func use_grappling_hook() -> void:
	is_on_cooldown = true
	
	mouse_position =  get_global_mouse_position()
	
	raycast.global_position = player.global_position
	raycast.target_position =  (mouse_position - player.global_position) * 5
	
	# apparently raycast collision is delayed by one frame, so it must be force updated
	raycast.force_raycast_update()
	if raycast.is_colliding():
		raycast_collision_point = raycast.get_collision_point()
		grappling_hook_missed = false
	else:
		raycast_collision_point = raycast.target_position + player.global_position
		grappling_hook_missed = true
	
	line2d.visible = true
	fire_chain()

## Tweens the chain position to the raycast collision point
func fire_chain() -> void:
	line2d.set_point_position(1, Vector2.ZERO)
	
	var tween: Tween = get_tree().create_tween()
	tween.tween_method(update_chain_sprite, line2d.get_point_position(0), 
	raycast_collision_point  - player.global_position, 0.2)
	
	await tween.finished
	if !grappling_hook_missed:
		player.is_in_grappling_hook = true
		player.movement_component.double_jump_active = true
	else:
		retract_chain()
		cooldown_timer.start(0.5)

## Used to tween the chain position
func update_chain_sprite(new_position: Vector2) -> void:
	line2d.set_point_position(0, new_position)

## Called every frame is_in_grappling_hook is true.
## Updates the chain sprite and player's velocity.
func update_grappling_hook() -> void:
	# update chain sprite
	line2d.set_point_position(0, raycast_collision_point - player.global_position)
	line2d.set_point_position(1, Vector2.ZERO)
	
	var distance: float = (raycast_collision_point - player.global_position).length()
	if distance < 70:
		player.velocity.x = move_toward(player.velocity.x, 0, 60)
		player.velocity.y = move_toward(player.velocity.y, 0, 60)
		player.move_and_slide()
		return
	
	# set player velocity
	var direction = raycast_collision_point - player.global_position
	direction = direction.normalized()
	# I think that clamping be velocity before adding it makes it more organic, I like it
	player.velocity.x = clamp(player.velocity.x, -max_grappling_speed, max_grappling_speed)
	player.velocity.y = clamp(player.velocity.y, -max_grappling_speed, max_grappling_speed)
	player.velocity += direction * grappling_speed
	
	player.move_and_slide()

func stop_using_grappling_hook() -> void:
	cooldown_timer.start(coolddown_duration)
	player.is_in_grappling_hook = false
	hovering = true
	
	retract_chain()

## Tweens the chain position back to the player
func retract_chain() -> void:
	line2d.set_point_position(1, Vector2.ZERO)
	
	var tween: Tween = get_tree().create_tween()
	tween.tween_method(update_chain_sprite, line2d.get_point_position(0), Vector2.ZERO, 0.2)
	
	await tween.finished
	line2d.visible = false

func _on_grappling_hook_cooldown_timeout() -> void:
	is_on_cooldown = false
