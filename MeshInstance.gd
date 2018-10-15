extends MeshInstance


var value


func _ready():
	value = get_node("../../UI/TextureRect2")
	pass

func _physics_process(delta):
	
	rotate_x(deg2rad(3))
	rotate_y(deg2rad(3))
	rotate_z(deg2rad(3))
	
	

func _on_Area_body_entered(body):
	value.skor += 1
	queue_free()
	pass # replace with function body
	
