extends Node2D

@export var player: Player
var gun_flash_scene = preload("res://Tech Art/Particles/Gun Flash/GunFlash.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	return
	
	if Input.is_action_just_pressed("Melee"):
		var gun_flash: ParticleManager = gun_flash_scene.instantiate()
		get_parent().add_child(gun_flash)
		gun_flash.global_position = player.global_position
