extends Spatial
var enemy


func _ready():
	enemy = get_node("../enemy")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Area_body_entered(body):
	if enemy.skor==10:
		get_tree().change_scene("res://victory.tscn")
	pass # replace with function body
