class_name Entity extends KinematicBody

export var speed = 5
export var gravity_power = 10
export var jump_power = 5

var geavity_points = []

var gravity_point = null
var velocity = Vector3()
var force = Vector3()

func gravity_controll(delta):
	if is_on_floor() or gravity_point == null:
		force = Vector3.ZERO
	else:
		force -= translation.direction_to(gravity_point) * delta * gravity_power

func colision_detect():
	for i in get_slide_count():
		_on_collide(get_slide_collision(i))

func calculate_gravity_point():
	gravity_point = Vector3()
	
	if not geavity_points.empty():
		for obj in geavity_points:
			var distance = translation.distance_to(obj.translation)
			var proportion = obj.get_gravity_radius() / distance
			gravity_point += translation + (translation - obj.translation) * proportion
		gravity_point = gravity_point / geavity_points.size()
	else:
		gravity_point = null

func rotation_controll():
	if gravity_point:
		var dir = gravity_point.direction_to(transform.origin).normalized()
		
		transform = transform.orthonormalized()
		if transform.basis.y.normalized().cross(-dir) != Vector3():
			look_at(gravity_point, transform.basis.y)
		elif transform.basis.x.normalized().cross(-dir) != Vector3():
			look_at(gravity_point, transform.basis.x)

func add_force(vec):
	force += vec

func add_gravity_point(obj):
	geavity_points.append(obj)
	
func remove_gravity_point(obj):
	if obj in geavity_points:
		var index = geavity_points.find(obj)
		geavity_points.remove(index)

func jump(power):
	if gravity_point:
		add_force(translation.direction_to(gravity_point) * power)

# Virtual function
func _on_collide(collision : KinematicCollision):
	pass
