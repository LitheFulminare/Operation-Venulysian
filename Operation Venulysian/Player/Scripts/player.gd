class_name Player
extends CharacterBody2D

@export_group("Components")
@export var movement_component: MovementComponent
@export var grappling_hook_component: GrapplingHookComponent
@export var attack_controller: AttackController
@export var weapon_controller: WeaponContoller

var is_movement_blocked: bool = false
var is_in_grappling_hook: bool = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Melee"):
		weapon_controller.shoot(global_position, Vector2(1,0))
		#attack_controller.melee_attack()

func _physics_process(delta: float) -> void:
	movement_component.move(delta)

func block_movement() -> void:
	is_movement_blocked = true
	
func unblock_movement() -> void:
	is_movement_blocked = false
