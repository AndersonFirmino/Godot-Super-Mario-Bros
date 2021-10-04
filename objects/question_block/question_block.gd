##
# Super Mario Bros 3
# Question Block Behavior
# coderpy (2019)
##
extends Block

#
# Bug: Eh possivel hitar o bloco mais de uma vez quando esta pulando.
#
#

func _on_hit_area_A_area_entered(area):
		if is_hitable and area.is_in_group("player") or area.is_in_group("throwable_enemy"):
			block_hitted_animation()
			check_coins()
			check_power_up()
