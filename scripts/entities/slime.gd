class_name Slime extends Entity

onready var view_field = $view_field
onready var animation = $animation

var _state = null

func _ready():
	_state = SlimeIdleState.new(self)
	_state.on_init()
	#visible=false
	
func set_state(state):
	_state.on_destroy()
	_state = state
	_state.on_init()

func _on_collide(collision : KinematicCollision):
	if collision.collider is Entity:
		var obj : Entity = collision.collider
		var vec = collision.normal - obj.transform.basis.z 
		
		obj.add_force(vec)

func _physics_process(delta):
	calculate_gravity_point()
	gravity_controll(delta)
	colision_detect()
	_state.on_update(delta)
