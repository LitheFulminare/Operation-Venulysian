class_name Projectile extends Area2D

var direction: Vector2
var speed: float

func _process(delta: float) -> void:
	global_position += (direction * speed) * delta

func shoot(dir: Vector2, velocity: float) -> void:
	direction = dir
	speed = velocity
	
func _on_timer_timeout() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	queue_free()
