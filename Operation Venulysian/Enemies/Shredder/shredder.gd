class_name Shredder extends Area2D

var rays: Array[RayCast2D]
var boids_in_sight: Array[Shredder]
var velocity: Vector2 = Vector2.ZERO
var speed: float = 7.0
var screen_size: Vector2
var movv: float = 35

func _ready() -> void:
	rays = get_rays()
	screen_size = get_viewport().get_visible_rect().size	
	randomize()
	
func get_rays() -> Array[RayCast2D]:
	var rayArray: Array[RayCast2D]
	for ray in $"Raycast folder".get_children():
		rayArray.append(ray)
	return rayArray

func _physics_process(delta: float) -> void:
	boids()
	checkCollision()
	
	velocity = velocity.normalized() * speed
	move()
	rotation = lerp_angle(rotation, velocity.angle_to_point(Vector2.ZERO), 0.4)
	

func move() -> void:
	global_position += velocity
	
	if global_position.x < 0:
		global_position.x = screen_size.x
	if global_position.x > screen_size.x:
		global_position.x = 0
		
	if global_position.y < 0:
		global_position.y = screen_size.y
	if global_position.y > screen_size.y:
		global_position.y = 0
	
func boids() -> void:
	if !boids_in_sight:
		return

	var number_of_boids := boids_in_sight.size()
	
	var avg_velocity := Vector2.ZERO
	var avg_position  := Vector2.ZERO
	var steer_away := Vector2.ZERO
	
	for boid in boids_in_sight:
		avg_velocity += boid.velocity
		avg_position += boid.position
		steer_away -= (boid.global_position - global_position) * (movv/(global_position - boid.global_position).length())
		
	avg_velocity /= number_of_boids
	velocity += (avg_velocity - velocity) / 2
	
	avg_position /= number_of_boids
	velocity += (avg_position - position)
	
	steer_away /= number_of_boids
	velocity += (steer_away)

func checkCollision() -> void:
	for ray in rays:
		if ray.is_colliding():
			var magi: float = 100 / (ray.get_collision_point() - global_position).length_squared()
			velocity -= (ray.target_position.rotated(rotation) * magi)


func _on_vision_area_2d_area_entered(area: Area2D) -> void:
	if area != self && area is Shredder:
		boids_in_sight.append(area)


func _on_vision_area_2d_area_exited(area: Area2D) -> void:
	if area != self && area is Shredder:
		boids_in_sight.erase(area)
