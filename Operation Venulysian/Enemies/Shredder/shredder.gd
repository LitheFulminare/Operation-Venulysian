class_name Shredder extends Area2D

var rays: Array[RayCast2D]

func _ready() -> void:
	rays = get_rays()
	
func get_rays() -> Array[RayCast2D]:
	var rayArray: Array[RayCast2D]
	for ray in $"Raycast folder".get_children():
		rayArray.append(ray)
	return rayArray
