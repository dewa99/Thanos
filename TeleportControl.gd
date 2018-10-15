extends Node

var target
var loc2
var player

func _ready():
	loc2 = get_node("../teleport2")
	player = get_node("../KinematicBody")
	pass



func _on_teleport1_body_entered(body):
	target = loc2.get_global_transform()
	player.set_global_transform(target)
	pass # replace with function body
