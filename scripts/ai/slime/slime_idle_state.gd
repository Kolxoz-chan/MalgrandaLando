class_name SlimeIdleState extends Resource

var _obj = null

func _init(obj):
	_obj = obj
	
func on_init():
	_obj.view_field.connect("body_entered", self, "on_body_in_view")
	
func on_destroy():
	pass

func on_body_in_view(body):
	if body is PlayerEntity:
		_obj.set_state(SlamePersecutionState.new(_obj, body))

func on_update(delta):
	pass
