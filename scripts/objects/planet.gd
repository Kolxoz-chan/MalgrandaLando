class_name Planet extends StaticBody
tool

var _radius = 10 

onready var _sphere = $Sphere
onready var _collider = $CollisionShape
onready var _gravity_field = $gravity_field
onready var _gravity_collider = $gravity_field/field

func _ready():
	_radius = randi() % 50 + 5
	
	_sphere.scale = Vector3(_radius, _radius, _radius)
	
	_collider.shape = SphereShape.new()
	_collider.shape.radius = _radius	
	
	_gravity_collider.shape = SphereShape.new()
	_gravity_collider.shape.radius = _radius * 2
	_gravity_field.connect("body_entered", self, "on_body_entered")	
	_gravity_field.connect("body_exited", self, "on_body_exited")	

func get_gravity_radius():
	return _gravity_collider.shape.radius

func on_body_entered(body):
	if body is Entity:
		body.add_gravity_point(self)
	
	if body is PlayerEntity:
		print(body)
	
func on_body_exited(body):
	if body is Entity:
		body.remove_gravity_point(self)
