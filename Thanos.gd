extends Spatial
var anim_player

var gravity = -9.8
var velocity = Vector3()
var camera

const SPEED = 9
const ACCELERATION = 3
const DEACCELERATION = 5

func _ready():
	camera = get_node("../Camera").get_global_transform()
	
	

func _physics_process(delta):
	var dir = Vector3()
	var anim_to_play = "Idle"
	
	if(Input.is_action_pressed("move_forward")):
		dir += -camera.basis[2]
	if(Input.is_action_pressed("move_backward")):
		dir += camera.basis[2]
	if(Input.is_action_pressed("move_left")):
		dir += -camera.basis[0]
	if(Input.is_action_pressed("move_right")):
		dir += camera.basis[0]
	
	dir.y = 0
	dir = dir.normalized()
	var hv = velocity
	
	velocity.y += delta * gravity
	hv.y = 0 
	
	var new_pos = dir * SPEED
	var accel = DEACCELERATION
	
	if(dir.dot(hv)>0):
		accel = ACCELERATION
		
	hv = hv.linear_interpolate(new_pos, accel * delta)
	
	velocity.x = hv.x
	velocity.y = hv.y
	
	velocity = move_and_slide(velocity, Vector3(0,1,0))
	
	
	