class_name WeaponContoller extends Node

@export_group("Components")
@export var projectile_scene: PackedScene

@export_group("Parameters")
@export var projectile_velocity: float = 1000.0

func shoot(spawn_position: Vector2, direction: Vector2) -> void:
	var projectile: Projectile = projectile_scene.instantiate()
	get_tree().root.add_child(projectile)
	projectile.shoot(direction, projectile_velocity)
	projectile.global_position = spawn_position
