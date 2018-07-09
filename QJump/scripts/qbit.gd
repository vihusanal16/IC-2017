extends KinematicBody2D

const GRAVITY = 800 # Pixels por segundo

const FLOOR_ANGLE_TOLERANCE = 40
const WALK_FORCE = 600
const WALK_MIN_SPEED = 20
const WALK_MAX_SPEED = 350
const STOP_FORCE = 1300
const JUMP_SPEED = 400
const JUMP_MAX_AIRBORNE_TIME = 0.2
const SLIDE_STOP_VELOCITY = 1.0 # Um pixel por segundo
const SLIDE_STOP_MIN_TRAVEL = 1.0 
var velocity = Vector2()
var on_air_time = 100
var jumping = false
var prev_jump_pressed = false

var troca_comandos = false
var portaH = 0

func _ready():
	set_z(20)
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	var d = 1
	var e = 1
	
	# Create forces
	var force = Vector2(0, GRAVITY)
	
	if get_pos().x >= 442:
		d = 0
		
	if get_pos().x <= 38:
		e = 0
	
	
#	if get_pos().y <= 25 or get_pos().y >= 465:
#		queue_free()
	
	var walk_left = Input.is_action_pressed("move_left")
	var walk_right = Input.is_action_pressed("move_right")
	var jump = Input.is_action_pressed("jump")
	var stop = true
	
	if troca_comandos:
		walk_left = Input.is_action_pressed("move_right")
		walk_right = Input.is_action_pressed("move_left")

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

	# Integrate forces to velocity
	velocity += force*delta

	# Integrate velocity into motion and move
	var motion = velocity*delta

	# Move and consume motion
	motion = move(motion)

	var floor_velocity = Vector2()

	if (is_colliding()):
		# You can check which tile was collision against with this
		# print(get_collider_metadata())
		
		# Ran against something, is it the floor? Get normal
		var n = get_collision_normal()
	
		#if (rad2deg(acos(n.dot(Vector2(0, -1)))) < FLOOR_ANGLE_TOLERANCE):
			# If angle to the "up" vectors is < angle tolerance
			# char is on floor
		#	on_air_time = 0
		#	floor_velocity = get_collider_velocity()

		if (on_air_time == 0 and force.x == 0 and get_travel().length() < SLIDE_STOP_MIN_TRAVEL and
abs(velocity.x) < SLIDE_STOP_VELOCITY and get_collider_velocity() == Vector2()):
			# Since this formula will always slide the character around,
			# a special case must be considered to to stop it from moving
			# if standing on an inclined floor. Conditions are:
			# 1) Standing on floor (on_air_time == 0)
			# 2) Did not move more than one pixel (get_travel().length() < SLIDE_STOP_MIN_TRAVEL)
			# 3) Not moving horizontally (abs(velocity.x) < SLIDE_STOP_VELOCITY)
			# 4) Collider is not moving
	
			revert_motion()
			velocity.y = 0.0

		else:
			# For every other case of motion, our motion was interrupted.
			# Try to complete the motion by "sliding" by the normal
			motion = n.slide(motion)
			velocity = n.slide(velocity)
			# Then move again
			move(motion)

	if (floor_velocity != Vector2()):
		# If floor moves, move with floor
		move(floor_velocity*delta)

	if (jumping and velocity.y > 0):
		# If falling, no longer jumping
		jumping = false

	if (on_air_time < JUMP_MAX_AIRBORNE_TIME and jump and not prev_jump_pressed and not jumping):
		# Jump must also be allowed to happen if the character left the floor a little bit ago.
		# Makes controls more snappy.
		velocity.y = -JUMP_SPEED
		jumping = true

	on_air_time += delta
	prev_jump_pressed = jump
	