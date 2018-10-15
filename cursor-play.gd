extends WorldEnvironment
var pause
var player
var spawner
var target
var gameover = 3
var life = []

func _ready():
	life.resize(3)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pause = get_node("pause")
	player = get_node("KinematicBody")
	spawner = get_node("spawnplayer")
	life[0] = get_node("UI/TextureRect/credit3")
	life[1] = get_node("UI/TextureRect/credit2")
	life[2] = get_node("UI/TextureRect/credit")
	
func _process(delta):
	if gameover==2:
		life[0].hide()
	if gameover==1:
		life[1].hide()
	if gameover==0:
		life[2].hide()
	
	
	if(Input.is_action_just_pressed("restart")):
		get_tree().reload_current_scene()
	if gameover==-1:
		get_tree().reload_current_scene()



func _on_Area_body_entered(body):
	gameover -=1
	target = spawner.get_translation()
	player.set_translation(target)
	pass # replace with function body



