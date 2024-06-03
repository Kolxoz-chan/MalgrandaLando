class_name GreenPlanet extends Planet

var stone = load("res://prefabs/objects/Stone.tscn")
var bush = load("res://prefabs/objects/Bush.tscn")
var tree = load("res://prefabs/objects/SimpleTree.tscn")

var slime = load("res://prefabs/entities/slime.tscn")

func _ready():
	
	# Objects
	generate_object(tree, 1, _radius)
	generate_object(bush, 1, _radius)
	generate_object(stone, 1, _radius)
	
	# Entities
	#generate_object(slime, 1, _radius)
	

func generate_object(object, min_count, max_count):
	var count = round(rand_range(min_count, max_count))
	for i in range(count):
		var x = rand_range(-1, 1)
		var y = rand_range(-1, 1)
		var z = rand_range(-1, 1)
		
		var vec = Vector3(x, y, z).normalized()
		
		var obj = object.instance()
		get_tree().current_scene.call_deferred("add_child", obj)
		
		obj.translation = translation + (vec * _radius)
		obj.rotation.x = atan2(vec.z, vec.y)
		obj.rotation.z = -atan2(vec.x, sqrt(vec.z * vec.z + vec.y * vec.y))
