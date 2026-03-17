extends Node2D

@export var target_scene: PackedScene

func _on_body_entered(body: Node2D) -> void:
	GameManager.go_to_scene(target_scene.resource_path)
