extends Area2D

var vel = 100

func _ready():
	set_z(10)
	set_process(true)
	pass
	
func _process(delta):
	
	set_pos(get_pos() + Vector2(0,-1) * vel * delta)
	
	if get_pos().y < -30:
		self.free()
		print("Free")
		pass
	pass

func _on_portaH_body_enter( body ):
	if body.get_layer_mask() == 8:
		game.troca_comandos = not game.troca_comandos
		game.posicao = not game.posicao
		queue_free()
	pass # replace with function body
