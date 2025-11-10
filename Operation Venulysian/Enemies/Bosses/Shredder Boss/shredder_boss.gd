class_name ShredderBoss extends Node2D

@export var shredder_spawn: Marker2D
@export var shredder_count: int = 1

var shredder_scene: PackedScene = preload("res://Enemies/Shredder/Shredder.tscn")

#func _ready() -> void:
	#spawn_shredders()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Melee"):
		spawn_shredders()

func spawn_shredders() -> void:
	for i in shredder_count:
		var shredder: Shredder = shredder_scene.instantiate()
		add_child(shredder)
		shredder.global_position = shredder_spawn.global_position
		print(shredder.global_position)
		print(shredder_spawn.global_position)
