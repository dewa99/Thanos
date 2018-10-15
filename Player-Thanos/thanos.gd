extends KinematicBody

var camera_angel = 0
var mouse_sensitivity = 0.3 
var velocity = Vector3()
var direction = Vector3()
var camera_cahnge = Vector2()

const fly_speed = 5
const fly_accel = 2
var flying = false

var gravity = -9.8 
const max_speed = 0.6
const max_running_speed = 3
const accel = 1
const deaccel = 30

var jump_height = 5
var anim_player

var timer = null
var attack_delay = 2
var is_attack = true
var Player


func _ready():
	
	anim_player = get_node("head/Thanos/AnimationPlayer")
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(attack_delay)
	timer.connect("timeout",self,"on_timeout_complete")
	add_child(timer)
	pass

func on_timeout_complete():
	is_attack = true

func _physics_process(delta):
	aim()
	if flying :
		fly(delta)
	else :
		walk(delta)
	walk(delta)


func _input(event):
	if event is InputEventMouseMotion:
		camera_cahnge = event.relative
		
	
func walk(delta):
	var is_walking = false
	var is_running = false
	var is_jump = false
	var is_punch = false
	var is_kick = false
	var anim_to_play = "Idle"
	
	
	var aim = $head/Camera.get_global_transform().basis 
	
	if Input.is_action_pressed("move_forward"):
		direction -= aim.z
		is_walking = true
	if Input.is_action_pressed("move_backward"):
		direction += aim.z
		is_walking = true
	if Input.is_action_pressed("move_left"):
		direction -= aim.x
		is_walking = true
	if Input.is_action_pressed("move_right"):
		direction += aim.x
		is_walking = true
	if (Input.is_action_pressed("punch") && is_attack):
		is_punch = true
		
	direction = direction.normalized()
	velocity.y += gravity * delta
	var temp_velocity = velocity
	temp_velocity.y = 0
	
	var speed
	if Input.is_action_pressed("move_sprint"):
		speed = max_running_speed
		if is_walking:
			is_running = true
	else:
		speed = max_speed 
	
	
	var target = direction * speed
	var acceleration
	if direction.dot(temp_velocity)>0:
		acceleration = accel
	else :
		acceleration = deaccel
	
	temp_velocity = temp_velocity.linear_interpolate(target, acceleration * delta)
	velocity.x = temp_velocity.x
	velocity.z = temp_velocity.z
	
	
	velocity = move_and_slide(velocity, Vector3(0,1,0))
	
	
	if is_on_floor() and Input.is_action_pressed("jump"):
		is_jump = true
		velocity.y = jump_height
		
	
	
	if is_walking :
		anim_to_play = "Walking"
	if is_running :
		anim_to_play = "Running"
	if is_jump :
		anim_to_play = "Jump"
	if is_punch :
		anim_to_play = "Hook Punch"
	if is_kick :
		anim_to_play = "Roundhouse Kick"
		
	var current_anim = anim_player.get_current_animation()
	if current_anim != anim_to_play:
		anim_player.play(anim_to_play)
	
	is_attack = false
	timer.start()


func fly(delta):
	direction = Vector3()
	
	var aim = $head/Camera.get_global_transform().basis 
	
	if Input.is_action_pressed("move_forward"):
		direction -= aim.z
	if Input.is_action_pressed("move_backward"):
		direction += aim.z
	if Input.is_action_pressed("move_left"):
		direction -= aim.x
	if Input.is_action_pressed("move_right"):
		direction += aim.x
		
	direction = direction.normalized()
	
	var target = direction * fly_speed
	
	velocity = velocity.linear_interpolate(target, fly_accel * delta)
	
	move_and_slide(velocity)
	
	
func aim():
	if camera_cahnge.length() > 0:
		$head.rotate_y(deg2rad(-camera_cahnge.x *mouse_sensitivity))
	
		var change = -camera_cahnge.y * mouse_sensitivity
		if change + camera_angel < 20 and change + camera_angel > -20:
			$head/Camera.rotate_x(deg2rad(change))
			camera_angel += change
		camera_cahnge = Vector2()

func _on_Area_body_entered(body):
	if body.name == "Player":
		flying = true


func _on_Area_body_exited(body):
	if body.name == "Player":
		flying = false