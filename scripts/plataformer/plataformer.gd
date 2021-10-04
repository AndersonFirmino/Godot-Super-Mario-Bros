##
# Class Plataformer
# Esta é uma classe que torna simples a criação de persongens com fisica do tipo plataforma
# Classe base para objetos (personagens) do tipo plataforma ex: Mario, Megamen, Sonic...
# coderpy (2019)
##
extends KinematicBody2D
class_name Plataformer

##
# Configuration variables
##
export var GRAVITY_VEC = Vector2(0, 900)
export var FLOOR_NORMAL = Vector2(0, -1)
export var SLOPE_SLIDE_STOP = 25.0
export var WALK_SPEED = 250 # pixels/sec
export var JUMP_SPEED = 480
export var SIDING_CHANGE_SPEED = 10
# Button setup
export var LEFT_BUTTON_STRING = ""
export var RIGHT_BUTTON_STRING = ""
export var JUMP_BUTTON_STRING = ""
export var ACTION_BUTTON_STRING = ""

# Caminho para o node do sprite (NAO é o node do sprite [objeto])
export(NodePath) var node_sprite

# Caminho para o node AnimationTree
export(NodePath) var animation_tree

##
# Variaveis internas
##
var linear_vel = Vector2()

var anim = ""

var is_walking = false
var is_jumping = false
var is_falling = false # TODO: Implement is_falling behavior
var on_floor = true

##
# Caso o personagem esteja com is_alive false os controles serão bloqueados
##
var is_alive = true

# cache the sprite here for fast access (we will set scale to flip it often)
onready var sprite = get_node(node_sprite)


func _physics_process(delta):
	### MOVEMENT ###

	# Apply gravity
	linear_vel += delta * GRAVITY_VEC
	# Move and slide
	linear_vel = move_and_slide(linear_vel, FLOOR_NORMAL, SLOPE_SLIDE_STOP)
	# Detect if we are on floor - only works if called *after* move_and_slide
	on_floor = is_on_floor()

	### CONTROL ###

	# Horizontal movement
	var target_speed = 0
	if Input.is_action_pressed(LEFT_BUTTON_STRING) and is_alive:
		target_speed -= 1
	if Input.is_action_pressed(RIGHT_BUTTON_STRING) and is_alive:
		target_speed += 1

	##################################################################
	# set states to daughter class
	is_walking = (Input.is_action_pressed(LEFT_BUTTON_STRING) and not Input.is_action_pressed(RIGHT_BUTTON_STRING) or not Input.is_action_pressed(LEFT_BUTTON_STRING) and Input.is_action_pressed(RIGHT_BUTTON_STRING)) and on_floor and is_alive
	is_jumping = true if not on_floor else false
	##################################################################

	target_speed *= WALK_SPEED
	linear_vel.x = lerp(linear_vel.x, target_speed, 0.1)

	# Jumping
	if on_floor and Input.is_action_just_pressed(JUMP_BUTTON_STRING) and is_alive:
		linear_vel.y = -JUMP_SPEED


	var new_anim = "idle"

	if on_floor:
		if linear_vel.x < -SIDING_CHANGE_SPEED:
			sprite.scale.x = -1
			new_anim = "run"

		if linear_vel.x > SIDING_CHANGE_SPEED:
			sprite.scale.x = 1
			new_anim = "run"
	else:
		# We want the character to immediately change facing side when the player
		# tries to change direction, during air control.
		# This allows for example the player to shoot quickly left then right.
		if Input.is_action_pressed(LEFT_BUTTON_STRING) and not Input.is_action_pressed("move_right") and is_alive:
			sprite.scale.x = -1
		if Input.is_action_pressed(RIGHT_BUTTON_STRING) and not Input.is_action_pressed("move_left") and is_alive:
			sprite.scale.x = 1

		if linear_vel.y < 0:
			new_anim = "jumping"

		else:
			new_anim = "falling"

#	if new_anim != anim:
#		anim = new_anim
#		($Anim as AnimationPlayer).play(anim)
