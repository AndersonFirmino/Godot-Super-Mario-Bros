extends Plataformer

export(String, "small mario", "super mario", "flower mario") var mario_states

var state_machine
var is_pressing_jump = false

func _ready():
	state_machine = $animation_tree.get("parameters/playback")
	# precisa setar a animação inicial para tudo funcionar adequadamente
	state_machine.start("idle")


func _process(delta):
	var current = state_machine.get_current_node()

	if is_walking and not is_jumping and is_alive:
		state_machine.travel("walking")

	elif is_jumping and is_alive:
		state_machine.travel("jumping")

	elif is_alive:
		state_machine.travel("idle")

	else:
		state_machine.travel("die")

func _input(event):
	is_pressing_jump = Input.is_action_pressed(JUMP_BUTTON_STRING)

	if is_pressing_jump and on_floor:
		SFX.mario_jump()

##
# Detecta se um inimigo colidiu com o Mario
##
func _on_corpo_body_entered(body):
	if body.is_in_group("inimigo") and is_alive:
		linear_vel = Vector2()
		morrer()


func morrer():
	if not is_alive:
		return
	clean_groups()
	$collision_shape_2d.set_deferred("disabled", true)
	is_alive = false
	linear_vel.y = -500
	MUSIC.play('dead_mario')
	get_tree().paused = true

	# temporary code! /!\
	$camera_2d.current = false


func clean_groups():
	remove_from_group("player")
	$corpo.remove_from_group("mario")
	$corpo.remove_from_group("player")
	$pes.remove_from_group("pes")
