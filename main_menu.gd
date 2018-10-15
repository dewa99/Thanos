extends Sprite



func _ready():
	
	pass




func _on_about_pressed():
	get_tree().change_scene("res://about.tscn")
	pass # replace with function body


func _on_start_pressed():
	get_tree().change_scene("res://loading.tscn")
	pass # replace with function body


func _on_exit_pressed():
	get_tree().quit()
	pass # replace with function body


func _on_help_pressed():
	get_tree().change_scene("res://instruction.tscn")
	pass # replace with function body
