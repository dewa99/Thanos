extends Spatial

var entered
var player
var hittime
var skor
var move_speed = 5


func _ready():
	player = get_node("../KinematicBody")
	hittime = get_node("../hittimer")
	skor = get_node("../UI/TextureRect2")
	pass

func _physics_process(delta):
	if entered==1 and Input.is_action_just_pressed("punch"):
		hittime.start()
	
	
	
	pass

func _on_Area_area_entered(area):
	entered=1
	pass # replace with function body


func _on_Area_area_exited(area):
	entered=0
	pass # replace with function body


func _on_hittimer_timeout():
	if entered==1:
		queue_free()
		skor.skor += 1
	pass # replace with function body
