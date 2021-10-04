##
# Class KinematicEnemy2D
# Classe base para os objetos inimigos do jogo adicionando um basico de fisica e movimento
# coderpy (2019)
##

extends KinematicBody2D
class_name KinematicEnemy2D


export var GRAVITY_VEC = Vector2(0, 900)
export var FLOOR_NORMAL = Vector2(0, -1)
export var SLOPE_SLIDE_STOP = 25.0
export var JUMP_SPEED = 480

# Define o movimento e a velocidade do movimento
export(float, -10000, 10000) var ENEMY_SPEED_X = 0
export(float, -10000, 10000) var ENEMY_SPEED_Y = 0

var linear_vel = Vector2()
var on_floor = null

enum direction {LEFT, RIGHT}
export (direction) var current_direction

func _physics_process(delta):
	# Apply gravity
	linear_vel += delta * GRAVITY_VEC
	# Move and slide (adds Physics)
	linear_vel = move_and_slide(linear_vel, FLOOR_NORMAL, SLOPE_SLIDE_STOP)
	# Detect if we are on floor - only works if called *after* move_and_slide
	on_floor = is_on_floor()

	# move de enemy
	if current_direction == direction.LEFT:
		translate(Vector2(-ENEMY_SPEED_X, ENEMY_SPEED_Y))

	elif current_direction == direction.RIGHT:
		translate(Vector2(ENEMY_SPEED_X, ENEMY_SPEED_Y))


##
# Efeito de fisica estilo super mario
# caso o player esteja apertando o botao de salto
# o objeto ira dar um impulso mais alto ao saltar sobre um inimigo
##
func set_player_jump_impulse(body):
	if body.is_in_group("player"):
		if body.is_pressing_jump:
				body.linear_vel.y = -800
		else:
			body.linear_vel.y = -400