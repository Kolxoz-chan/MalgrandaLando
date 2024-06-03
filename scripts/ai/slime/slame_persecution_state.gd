class_name SlamePersecutionState extends Resource

var _obj : Entity = null
var _target : Entity = null

func _init(obj, target):
	_obj = obj
	_target = target
	
func on_init():
	_obj.animation.connect("animation_finished", self, "on_animation_finished")
	
func on_destroy():
	pass
	
func on_animation_finished(name):
	pass

func on_update(delta):
	var vec = Vector3.ZERO
	
	if _target and _obj.gravity_point:
		var up = -_obj.translation.direction_to(_obj.gravity_point).normalized()
		_obj.look_at(_target.translation, up)
		
		if _obj.is_on_floor():
			if not _obj.animation.is_playing():
				_obj.animation.play("landing")
			else:
				_obj.jump(_obj.jump_power)
		else:
			var dir = _obj.translation.direction_to(_target.translation)
			vec += dir * _obj.speed
		
	
		vec -= _obj.force
		_obj.move_and_slide(vec, up)

