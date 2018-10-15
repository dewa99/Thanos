extends TextureRect
var text
var value
var skor = 0

func _ready():
	
	text = get_node("Label2")
	value = get_node("../../PickableItem/item")
	
	pass
	
func _process(delta):
	text.text = str(skor)
	pass
