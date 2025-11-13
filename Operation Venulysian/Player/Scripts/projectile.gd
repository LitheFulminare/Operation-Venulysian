class_name Projectile extends Area2D

var direction: Vector2
var speed: float

func _process(delta: float) -> void:
	global_position += (direction * speed) * delta

func shoot(direction: Vector2, speed: float) -> void:
	self.direction = direction
	self.speed = speed
	
func _on_timer_timeout() -> void:
	print("Projectile despawning")
	queue_free()
