class_name PlayerEntity extends Entity

var _lerp_coef = 0.3
var _mouse_sense = 0.004
var mouse_delta = Vector2.ZERO

func _ready():
	pass
	

func _input(event):
	if event is InputEventMouseMotion:
		mouse_delta += event.relative * -_mouse_sense
	

func camera_motion():
	var delta = lerp(Vector2.ZERO, mouse_delta, _lerp_coef)
	mouse_delta -= delta
	
	rotate(transform.basis.z, delta.x)
	$Camera.rotation.x = clamp($Camera.rotation.x + delta.y, 0, PI)

func controll(vec):
	
	if Input.is_key_pressed(KEY_W):
		vec += transform.basis.y * speed
		
	if Input.is_key_pressed(KEY_S):
		vec -= transform.basis.y * speed
		
	if Input.is_key_pressed(KEY_A):
		vec -= transform.basis.x * speed
		
	if Input.is_key_pressed(KEY_D):
		vec += transform.basis.x * speed
		
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
		
	if Input.is_key_pressed(KEY_SPACE) and is_on_floor():
		force = -jump_power * transform.basis.z
		
	return vec

func gravity_controll(delta):
	if is_on_floor() or gravity_point == null:
		force = Vector3.ZERO
	else:
		force += transform.basis.z * delta * gravity_power

func _physics_process(delta):
	calculate_gravity_point()
	rotation_controll()
	gravity_controll(delta)
	colision_detect()
	camera_motion()
	
	# Motion controll
	var velocity = Vector3()
	var vec = controll(velocity)
	vec -= force
	
	move_and_slide(vec, transform.basis.z)
