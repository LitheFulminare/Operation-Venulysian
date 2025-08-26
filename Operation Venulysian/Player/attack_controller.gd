class_name AttackController
extends Node

@export var player: Player
@export var attack_window_timer: Timer
@export var damage: float = 10
## How much time the player has to chain one attack into the other (in seconds)
@export var combo_window: float = 0.5

var is_combo_window_active: bool = false
var current_attack: int = 1

func _ready() -> void:
	attack_window_timer.wait_time = combo_window

func melee_attack():
	# First I should check if the player is in the middle of the animation,
	# but I don't have that now
	
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
