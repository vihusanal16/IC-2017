extends Node

var pre_plataforma = preload("res://scenes/plataforma.tscn")
var pre_vermelha = preload("res://scenes/plataforma_vermelha.tscn")
var pre_portaX = preload("res://scenes/portaX.tscn")
var pre_portaH = preload("res://scenes/portaH.tscn")
var intervalo = .8
var dificuldade = 0
var contador = 3
#TODO: criar constantes com números magicos

func _ready():
	randomize()
	set_process(true)
	pass

func _process(delta):
	if intervalo >= 0:
		intervalo -= delta
	else:
		var plataforma = pre_plataforma.instance()
		
		if dificuldade <= 15:
			plataforma.vel = 100
			intervalo = 1.3
			if dificuldade == 15:
				plataforma.vel = 112
			pass
		elif dificuldade > 15 and dificuldade <= 30:
			plataforma.vel = 125
			intervalo = 1.1
			if dificuldade == 30:
				plataforma.vel = 137
			pass
		elif dificuldade > 30  and dificuldade <= 50:
			plataforma.vel = 150
			intervalo = .9
			if dificuldade == 50:
				plataforma.vel = 162
			pass
		elif dificuldade > 50 and dificuldade <= 90:
			plataforma.vel = 175
			intervalo = .7
			if dificuldade == 90:
				plataforma.vel = 190
			pass
		else:
			plataforma.vel = 200
			intervalo = .5
		
		#Gerando plataforma vermelha
		#if contador == 1:
			#var vermelha = pre_vermelha.instance()
			#get_owner().add_child(vermelha)
			#vermelha.vel = plataforma.vel
			#vermelha.set_pos(Vector2(rand_range(60,330),550))
			#pass
		get_owner().add_child(plataforma)
		plataforma.set_pos(Vector2(rand_range(60,330),550))
	
		#Gerando portaX
		if contador == 2:
			var portax = pre_portaX.instance()
			get_owner().add_child(portax)
			portax.set_pos(plataforma.get_node("posPorta").get_global_pos())
			portax.vel = plataforma.vel
			pass
	
		#Gerando portaH
		#if contador == 2:
			#var portah = pre_portaH.instance()
			#get_owner().add_child(portah)
			#portah.set_owner(get_owner())
			#portah.set_pos(plataforma.get_node("posPorta").get_global_pos())
			#portah.vel = plataforma.vel
			#pass
		
		
		dificuldade += 1
		contador = round(rand_range(1,4))
		pass
		
	pass