class_name Shredder extends Area2D

var rays: Array[RayCast2D]
var boids_in_sight: Array[Shredder]
var velocity: Vector2 = Vector2.ZERO
var speed: float = 7.0
var screen_size: Vector2

func _ready() -> void:
	rays = get_rays()
	screen_size = get_viewport_rect().size
	randomize()
	
func get_rays() -> Array[RayCast2D]:
	var rayArray: Array[RayCast2D]
	for ray in $"Raycast folder".get_children():
		rayArray.append(ray)
	return rayArray

func _process(delta: float) -> void:
	boids()
	checkCollision()
	velocity = velocity.normalized() * speed
	move()
	rotation = lerp_angle(rotation, velocity.angle_to_point(Vector2.ZERO), 0.4)
