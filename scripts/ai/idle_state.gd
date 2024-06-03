class_name IdleState extends Resource

var _obj = null

func _init(obj):
	_obj = obj
	
func on_init():
	_obj.view_field.connect("body_entered", self, "on_body_in_view")
	
func on_destroy():
	pass

func on_body_in_view(body):
	if body is PlayerEntity:
		pass

func on_update(delta):
	var up = _obj.translation.normalized()
	var vec = Vector3.ZERO
	
	if _obj.is_on_floor():
		_obj._gravity = 0
	else:
		_obj._gravity += 10 * delta
	
	"""
	if _target:
		look_at(_target.translation, up)
		
		if is_on_floor():
			_gravity = -5
		else:
			vec -= transform.basis.z * _speed 
			vec -= up * _gravity
	"""
		
	_obj.move_and_slide(vec, up)
