extends Area2D

var pre_qbit1 = preload("res://scenes/qbit.tscn")

func _ready():
	pass

func _on_bordas_body_enter( body ):
	if body.get_layer_mask() == 8 and game.teste == 1:
		print("QBIT colidiu")
		var qbit1 = pre_qbit1.instance()
		get_owner().add_child(qbit1)
		qbit1.set_pos(self.get_global_pos())
		game.teste = 0
		game.lifes -= 1
		get_tree().reload_current_scene()
		if game.lifes <= 0:
			get_tree().finish()
	else:
		game.teste = 1
		