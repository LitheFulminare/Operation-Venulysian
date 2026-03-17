## AUTOLOADED SCRIPT
extends Node

var current_scene = null

func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func go_to_scene(scene_path: String) -> void:
	call_deferred("_deferred_scene_change", scene_path)

func go_to_loaded_scene(scene: PackedScene) -> void:
	call_deferred("_deferred_loaded_scene_change", scene)

func _deferred_scene_change(scene_path: String) -> void:
	current_scene.free()
	var new_scene = load(scene_path)
	current_scene = new_scene.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene

func _deferred_loaded_scene_change(scene: PackedScene) -> void:
	current_scene.free()
	current_scene = scene.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
