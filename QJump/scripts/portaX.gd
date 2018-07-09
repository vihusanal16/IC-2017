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
		pass


func _on_portaH_body_enter( body ):
	if body.get_layer_mask() == 8 and body.portaH == 0:
		game.estado_inicial = body.posicao
		#Criando outro qbit
		var qbitH = pre_qbit.instance()
		get_owner().add_child(qbitH)
		qbitH.set_pos(self.get_global_pos())
		
		#Invertendo o qbit criado
		#if body.posicao == 1:
			#qbit.posicao = 0
		#else:
			#qbit.posicao = 1
		
		#qbitH.troca_comandos += 1
		#qbit.portaH += 1
		#body.portaH += 1
		#Apagando a porta
		#self.queue_free()
	#elif body.get_layer_mask() == 8 and body.portaH > 0:
		#game.morreu = 1
		#game.posicao = game.estado_inicial
		#self.queue_free()
		#body.queue_free()
	#pass # replace with function body
