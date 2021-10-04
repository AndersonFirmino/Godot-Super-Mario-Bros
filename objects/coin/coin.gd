##
# Super Mario Bros 3
# Coins (coletaveis)
# (coderpy) 2019
##
extends Area2D


##
# Setup da cor da moeda
##
enum COLOR {A, B}
export(COLOR) var current_color



func _ready():
	if current_color == COLOR.A:
		$animation_player.play("coin_a")

	else:
		$animation_player.play("coin_b")



func _on_coin_area_entered(area):
	if area.is_in_group("player"):
		SFX.coin()
		queue_free()
