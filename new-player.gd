extends KinematicBody
var camera_angle = 0
var mouse_sensitivity = 0.3

var velocity = Vector3()
var direction = Vector3()

var gravity = -9.8 * 3.5
const MAX_SPEED = 1
const MAX_RUNNING_SPEED = 10
const ACCEL = 2
const DEACCEL = 100

var jump_height = 15
var physic_status = 0
var anim_player
var timer
var punch

#trigger
var is_jump = true
var punch_on = true
var is_moving = true
var hit_counter = 0


func _ready():
	anim_player = get_node("head/thanos/AnimationPlayer")
	timer = $Timer
	punch = $hitcounter
	pass

func _physics_process(delta):
	
	walk(delta)
	


func walk(delta):
	is_jump = false
	punch_on = true
	is_moving = true
	
	direction = Vector3()
	var aim = $head/Camera.get_global_transform().basis
	physic_status = 0
	
	if is_moving:
		if Input.is_action_pressed("move_forward"):
			direction -= aim.z
			physic_status = 1
		if Input.is_action_pressed("move_backward"):
			direction += aim.z
	
	if Input.is_action_just_pressed("punch") and punch_on:
		punch.start()
		
	
	if $hitcounter.time_left<0:
		physic_status = 4
		is_moving  = false
		punch_on = false
	
	direction = direction.normalized()
	velocity.y += gravity * delta
	var temp_velocity = velocity
	temp_velocity.y = 0
	
	var speed
	if Input.is_action_pressed("move_sprint") and physic_status == 1 and is_jump == false:
		speed = MAX_RUNNING_SPEED
		physic_status = 2
	else :
		speed = MAX_SPEED
	
	var target = direction * speed
	
	var acceleration
	if direction.dot(temp_velocity)>0:
		acceleration = ACCEL
	else:
		acceleration = DEACCEL
	
	temp_velocity = temp_velocity.linear_interpolate(target,acceleration * delta)
	velocity.x = temp_velocity.x
	velocity.z = temp_velocity.z
	
	velocity = move_and_slide(velocity, Vector3(0,1,0))
	
	var anim_to_play
	
	#jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		is_jump = true
		timer.start()
		velocity.y = jump_height
	
	
	
	if timer.time_left >0 :
		physic_status = 3
	
	
	#Animation Setting
	
	if physic_status == 0:
		anim_to_play = "Idle"
	if physic_status == 1:
		anim_to_play = "Walking"
	if physic_status == 2:
		anim_to_play = "Running"
	if physic_status == 3:
		anim_to_play = "Jump"
	if physic_status == 4:
		anim_to_play = "punch1"
		if hit_counter == 1:
			anim_to_play = "punch2"
		
	
	
	
		
	
	
	
	var current_anim = anim_player.get_current_animation()
	if current_anim != anim_to_play:
		anim_player.play(anim_to_play)
	
	
func _input(event):
	if event is InputEventMouseMotion:
		$head.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		
		var change = -event.relative.y * mouse_sensitivity
		if change + camera_angle < 30 and change+camera_angle>-20:
			$head/Camera.rotate_x(deg2rad(change))
			camera_angle +=change

func _on_Timer_timeout():
	is_jump = false
	pass 


func _on_hitcounter_timeout():
	hit_counter += 1
	punch_on = true

	if hit_counter == 2:
		hit_counter = 0
		
	pass # replace with function body
