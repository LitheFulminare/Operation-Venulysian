class_name ShredderBoss extends Node2D

@export var shredder_spawn: Marker2D
@export var shredder_count: int = 2

@export var shredder_scene: PackedScene

#func _ready() -> void:
	#spawn_shredders()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		spawn_shredders()

func spawn_shredders() -> void:
	for i in shredder_count:
		var shredder: Shredder = shredder_scene.instantiate()
		add_child(shredder)
		shredder.global_position = shredder_spawn.global_position
		
		if i % 2 == 0:
			shredder.global_position.x += 10
