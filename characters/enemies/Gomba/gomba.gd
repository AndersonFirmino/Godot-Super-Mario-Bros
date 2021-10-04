extends KinematicEnemy2D

# TODO:
# Ajustar velocidade das animações
# setar as cores do gomba para ser trocada dinamicamente
# - Adicionar o score e o sistema de score e vida caso acerte varios de uma vez.

export(String) var color

##
# Procedimento especifico do Goomba quando o mario pisa nele
##
func morrer(obj):
	if obj.is_in_group("pes") and obj.get_owner().is_alive:
		SFX.gomba_smashed()
		$animation_player.play("dead")
		$collision_shape_2d.set_deferred("disabled", true)
		$hitbox/collision_shape_2d.set_deferred("disabled", true)
		set_physics_process(false)
		set_player_jump_impulse(obj.get_owner())
		yield(get_tree().create_timer(0.4), "timeout")
		queue_free()


func _on_change_direction_left_collision():
	current_direction = direction.RIGHT


func _on_change_direction_right_collision():
	current_direction = direction.LEFT


##
# Trata a colisão com o pé do mario
##
func _on_hitbox_area_entered(area):
	morrer(area)
