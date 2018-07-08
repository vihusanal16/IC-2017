extends Area2D

func _ready():
	pass

func _on_bordas_body_enter( body ):
	if body.get_layer_mask() == 8 and game.teste == 1:
		print("QBIT colidiu")
		game.teste = 0
		game.lifes -= 1
	else:
		game.teste = 1
		