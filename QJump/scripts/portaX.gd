extends Area2D

var pre_qbit = preload("res://scenes/qbitH.tscn")
var vel = 100
var usado = 1

func _ready():
	set_process(true)
	pass

func _process(delta):
	
	set_pos(get_pos() + Vector2(0,-1) * vel * delta)
	
	if get_pos().y < -30:
		
		#print("Free")
		pass
	pass


func _on_portaH_body_enter( body ):
	if body.get_layer_mask() == 8:
		
		if game.estado == game.MORTO:
			#Criando outro qbit
			var qbitH = pre_qbit.instance()
			get_owner().add_child(qbitH)
			qbitH.set_pos(self.get_global_pos())
			queue_free()
			game.estado = game.VIVO
		elif game.estado == game.VIVO:
			game.estado = game.SUPERPOSICAO
			queue_free()
		else:
			game.estado = game.VIVO
			var qbitH = pre_qbit.instance()
			get_owner().add_child(qbitH)
			qbitH.set_pos(self.get_global_pos())
			queue_free()
			
		pass
		
	
	#Apagando a porta
	
	pass