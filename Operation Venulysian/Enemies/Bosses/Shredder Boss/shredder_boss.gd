class_name ShredderBoss extends Node2D

@export_group("Components")
@export var shredder_spawn: Marker2D
@export var shredder_scene: PackedScene
@export var shredder_spawner: ShredderSpawner
@export var shredder_boundary: CollisionShape2D

@export_group("Parameters")
@export var shredder_count: int = 4
@export var shredder_spawn_delay: float = 0.5

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		spawn_shredders()

func spawn_shredders() -> void:
	for i in shredder_count:
		var shredder: Shredder = shredder_scene.instantiate()
		add_child(shredder)
		shredder.global_position = shredder_spawn.global_position
		shredder.rotate(deg_to_rad(270))
		
		var shape := shredder_boundary.shape as RectangleShape2D
		var half := shape.size * 0.5
		var top_left := shredder_boundary.global_position - half
		shredder.boundary_rect = Rect2(top_left, shape.size)
		
		if i % 2 == 0:
			shredder.global_position.x += 10
			
		await get_tree().create_timer(shredder_spawn_delay).timeout
