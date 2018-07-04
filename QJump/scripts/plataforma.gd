extends StaticBody2D 

var vel = 100

func _ready():
	set_z(0)
	set_process(true)
	pass

func _process(delta):
	set_pos(get_pos() + Vector2(0,-1) * vel * delta)
	
	if get_pos().y < -30:
		free()
	
	pass
	