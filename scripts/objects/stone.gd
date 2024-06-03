extends StaticBody

var _radius =  1

onready var _sphere = $Sphere
onready var _collider = $CollisionShape

func _ready():
	_radius = rand_range(0.25, 3)
	
	if _collider.shape:
		_collider.shape.radius = _radius
		
	_sphere.scale = Vector3(_radius, _radius, _radius)
