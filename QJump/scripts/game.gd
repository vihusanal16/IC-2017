extends Node

const GRUPO_QBIT = "qbit"
var posicao = 0
var estado_inicial
var morreu = 0
var cont = 0

var score = 0 setget setScore

signal score_changed

func _ready():
	set_process(true)
	pass
	
func _process(delta):
	cont += 100
	setScore(cont)
	pass
	
func setScore(valor):
	if valor % 5 == 0:
		score += 1
	
	emit_signal("score_changed")
	pass
