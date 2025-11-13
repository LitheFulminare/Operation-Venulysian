class_name AttackController
extends Node

@export_group("Components")
@export var player: Player
@export var attack_window_timer: Timer
@export var sword_hitbox: Area2D
## Controls for how long the sword hitbox will be active looking for collision
@export var sword_hit_window_timer: Timer

@export_group("Parameters")
@export var damage: float = 10
## How much time the player has to chain one attack into the other (in seconds)
@export var combo_window: float = 0.5
## Controls for how long the sword hitbox will be active looking for collision
@export var sword_hit_window: float = 0.2

var is_combo_window_active: bool = false
var current_attack: int = 1

func _ready() -> void:
	attack_window_timer.wait_time = combo_window
	#sword_hit_window.waittime
	sword_hitbox.monitoring = false

func melee_attack():
	# First I should check if the player is in the middle of the animation,
	# but I don't have that now
	
	sword_hitbox.monitoring = true
	sword_hit_window_timer.start()
	
	match current_attack:
		1:
			print("Attack 1")
		2:
			print("Attack 2")
		3:
			print("Attack 3")
			
	is_combo_window_active = true
	
	if current_attack == 3:
		current_attack = 1
	else:
		current_attack += 1
		attack_window_timer.start()

func _on_combo_window_timer_timeout() -> void:
	is_combo_window_active = false
	current_attack = 1


func _on_sword_hit_window_timeout() -> void:
	sword_hitbox.monitoring = false
