extends Node

const GRUPO_QBIT = "qbit"
var posicao = 0
var estado_inicial
var morreu = 0
var cont = 0
var teste = 1
var objeto
var troca_comandos = false
var movimento = Vector2()

enum {VIVO, MORTO, SUPERPOSICAO}
var estado = MORTO

var score = 0 setget setScore
var lifes = 3 setget setLifes

signal score_changed
signal lifes_changed

func _ready():
	randomize()
	set_process(true)
	pass
	
func _process(delta):
	cont += 100
	setScore(cont)
	pass
	
func setScore(valor):
	if valor != 0:
		if valor % 5 == 0:
			score += 1
	else:
		score = 0
	emit_signal("score_changed")

func setLifes(valor):
	lifes = valor
	emit_signal("lifes_changed")
