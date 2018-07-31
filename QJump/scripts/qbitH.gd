extends KinematicBody2D

const GRAVITY = 800 # Pixels por segundo
const MACRO = 10000
const WALK_FORCE = 600
const WALK_MIN_SPEED = 10
const WALK_MAX_SPEED = 310
const STOP_FORCE = 1300
const SLIDE_STOP_MIN_TRAVEL = 1.0 
const SLIDE_STOP_VELOCITY = 1.0 # Um pixel por segundo
const SLIDE_STOP_MIN_TRAVEL = 1.0 

var velocity = Vector2()
var on_air_time = 100
var velocidade = MACRO
var direcao = Vector2()
var position = Vector2()
var objeto

func _ready():
	set_process(true)
	pass

func _process(delta):
	
	if game.estado == game.SUPERPOSICAO:
		queue_free()
	
	var force = Vector2(0,0)
	
	var d = 1
	var e = 1
	
	if get_pos().x >= 345:
		d = 0
		
	if get_pos().x <= 55:
		e = 0
	
	var walk_left = Input.is_action_pressed("move_right")
	var walk_right = Input.is_action_pressed("move_left")
	var stop = true
	
	if game.troca_comandos:
		walk_right = Input.is_action_pressed("move_right")
		walk_left = Input.is_action_pressed("move_left")
	
	if(walk_right and walk_left):
		walk_left = false
		walk_right = false
	
	if (walk_left and e):
		if (velocity.x <= WALK_MIN_SPEED and velocity.x > -WALK_MAX_SPEED):
			force.x -= WALK_FORCE
			stop = false
	elif (walk_right and d):
		if (velocity.x >= -WALK_MIN_SPEED and velocity.x < WALK_MAX_SPEED):
			force.x += WALK_FORCE
			stop = false
	
	if (stop):
		var vsign = sign(velocity.x)
		var vlen = abs(velocity.x)
		vlen -= STOP_FORCE*delta
		
		if (vlen < 0):
			vlen = 0
		velocity.x = vlen*vsign
	
	velocity += force*delta

	# Integrate velocity into motion and move
	var motion = velocity*delta
	
	motion = move(motion)
	
	var floor_velocity = Vector2()

	if (is_colliding()):

		var n = get_collision_normal()
	

		if (on_air_time == 0 and force.x == 0 and get_travel().length() < SLIDE_STOP_MIN_TRAVEL and
abs(velocity.x) < SLIDE_STOP_VELOCITY and get_collider_velocity() == Vector2()):
			revert_motion()
			velocity.y = 0.0

		else:
			motion = n.slide(motion)
			velocity = n.slide(velocity)
			game.movimento = move(motion)

	if (floor_velocity != Vector2()):
		game.movimento = move(floor_velocity*delta)
	
	position = get_global_pos()
	objeto = game.objeto

	
	if objeto != null:
		direcao = (objeto.get_global_pos() - position).normalized()
#		direcao.x = 0

		translate(velocidade * Vector2(0, direcao.y) * delta)
		pass
	
	pass