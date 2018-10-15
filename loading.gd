extends Sprite
var timer
var text
var time

func _ready():
	text = get_node("Label2")
	time = 0
	
	pass
func _process(delta):
	time +=1 * delta * 20
	text.text = str(int(time))
	
	if time>=100:
		get_tree().change_scene("res://main.tscn")
