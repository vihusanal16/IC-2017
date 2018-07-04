extends Area2D

var vel = 0

func _ready():
	set_process(true)
	pass

func _process(delta):
	var d = 0
	var e = 0
	
	#Neste "if" o qbit responderá de forma contrária ao qbit principal
	if Input.is_action_pressed("move_left"):
		set_pos(get_pos() + Vector2(1,0) * 150 * delta)
	#Neste "if" o qbit responderá de forma contrária ao qbit principal
	if Input.is_action_pressed("move_right"):
		set_pos(get_pos() + Vector2(-1,0) * 150 * delta)
	
	#Setando o qbit para cima, para que quando ele encoste em alguma plataforma
	#o qbit suba
	set_pos(get_pos() + Vector2(0,-1) * vel * delta)
	
	pass

#Função para fazer o qbit subir quando encostar em alguma plataforma
func _on_Area2D_body_enter( body ):
	print(body)
	#self.vel = body.vel
	pass # replace with function body

#Função para fazer o qbit parar de subir quando desencostar da plataforma
func _on_Area2D_body_exit( body ):
	#self.vel = 0
	pass # replace with function body
