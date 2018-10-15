extends Spatial

var anim_player

func _ready():
	anim_player = get_node("AnimationPlayer")
	pass

func _physics_process(delta):
	if(Input.is_action_pressed("move_forward"):
		