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

func _ready() -> void:
	cooldown_timer.wait_time = coolddown_duration
	line2d.visible = false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Grappling Hook"):
		if player.is_in_grappling_hook:
			stop_using_grappling_hook()
		elif !is_on_cooldown:
			use_grappling_hook()

## Called once when the player presses Grappling Hook button
func use_grappling_hook() -> void:
	is_on_cooldown = true
	player.is_in_grappling_hook = true
	player.movement_component.double_jump_active = true
	
	mouse_position =  get_global_mouse_position()
	
	raycast.global_position = player.global_position
	raycast.target_position =  (mouse_position - player.global_position) * 5
	
	# apparently raycast collision is delayed by one frame, so it must be force updated
	raycast.force_raycast_update()
	raycast_collision_point = raycast.get_collision_point()
	
	line2d.visible = true
	line2d.set_point_position(0, raycast_collision_point  - player.global_position)
	line2d.set_point_position(1, Vector2.ZERO)

## Called every frame is_in_grappling_hook is true.
## Updates the chain sprite and player's velocity.
func update_grappling_hook() -> void:
	# update chain sprite
	line2d.set_point_position(0, raycast_collision_point - player.global_position)
	line2d.set_point_position(1, Vector2.ZERO)
	
	# set player velocity
	var direction = raycast_collision_point - player.global_position
	direction = direction.normalized()
	# I think that clamping be velocity before adding it makes it more organic, I like it
	player.velocity.x = clamp(player.velocity.x, -max_grappling_speed, max_grappling_speed)
	player.velocity.y = clamp(player.velocity.y, -max_grappling_speed, max_grappling_speed)
	player.velocity += direction * grappling_speed
	
	player.move_and_slide()

func stop_using_grappling_hook() -> void:
	cooldown_timer.start()
	player.is_in_grappling_hook = false
	line2d.visible = false
	hovering = true

func _on_grappling_hook_cooldown_timeout() -> void:
	is_on_cooldown = false
