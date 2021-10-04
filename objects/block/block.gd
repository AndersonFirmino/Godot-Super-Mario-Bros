##
# Class Block
# Classe Bloco abstraindo a logica de um bloco do mario
# coderpy (2021)
##
# OBS: O no filho precisa ter um Tween e um animation_player com uma
# animacao de nome: collision_a
# /!\ caso náo possua havera problemas com a classe mae

extends StaticBody2D
class_name Block

# controla se o bloco pode ou nao ser alvejado novamente pelo Mario
export(bool) var is_hitable = true
# Total de moedas dentro de um bloco
export(int, 99) var coins
# Tipos de PowerUps Basicos
export(String, 'mushroom', 'flower', 'star', 'coin', 'none') var power_up = 'none'

# rotating coin animation
var RotatingCoin = load("res://objects/coin/coin_rotating.tscn")

# floating score animation and setup
var FloatingScore = load("res://objects/floating_score/floating_score.tscn")

var floating_score_value = 0

func _ready():
	pass # Replace with function body.

##
# Faz a animacao do bloco saltando
##
func block_hitted_animation():
	$Tween.interpolate_property(
		self,
		'position',
		position,
		position - Vector2(0, 20),
		0.09,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
	)
	$Tween.start()
	var coin = RotatingCoin.instance()
	$coin_spawn.add_child(coin)
	yield($Tween, "tween_completed")
	$Tween.interpolate_property(
		self,
		'position',
		position,
		position - Vector2(0, -20),
		0.09,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
	)
	$Tween.start()
	yield($Tween, "tween_completed")
	var fs = FloatingScore.instance()
	fs.set_score(str(floating_score_value))
	get_tree().current_scene.add_child(fs)
	fs.global_position = $coin_spawn.global_position

	fs.do_floating_effect()


##
# Faz o controle de moedas para impedir o mario de bater no bloco novamente
# TODO: se o mario n bater a tempo no bloco ele perde o direito do bonus
##
func check_coins():
	if coins > 0:
		coins -= 1
		floating_score_value = 200

		if coins == 0:
			is_hitable = false
			$animation_player.play("collision_a")

##
# Spawna o PowerUp e fecha o bloco para não ser mais acertado
##
func check_power_up():
	if coins == 0 and "coin" in power_up:
		is_hitable = false
		$animation_player.play("collision_a")

	elif power_up in ['mushroom', 'flower', 'star']:
		power_up = "none"
		is_hitable = false
		$animation_player.play("collision_a")
