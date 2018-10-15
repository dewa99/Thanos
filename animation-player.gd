extends KinematicBody

var anim_player
#1.walk 2.run 3.jump 4.punch 5.kick

func _ready():
	anim_player = get_node("head/thanos/AnimationPlayer")
	pass

func _physics_process(delta):
	var anim_to_play = "Idle"
	
	
	if physic_status == 1:
		anim_to_play = "Walking"
	
	var current_anim = anim_player.get_current_animation()
	if current_anim != anim_to_play:
		anim_player.play(anim_to_play)
