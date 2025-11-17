class_name ShredderSpawner extends Node2D

@export var shredders: Array[Shredder]

func spawn() -> void:
	visible = true
	for s in shredders:
		s.velocity = s.initial_direction * s.speed
		s.active = true
