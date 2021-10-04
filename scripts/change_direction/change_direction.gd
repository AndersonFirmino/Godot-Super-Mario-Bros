##
# Script que adiciona o comportamento de um objeto avisar o lado que colidiu
##

extends Node2D

signal left_collision
signal right_collision

func _on_left_body_entered(body):
	if body.is_in_group("ground") or body.is_in_group("goomba"):
		emit_signal("left_collision")


func _on_right_body_entered(body):
	if body.is_in_group("ground") or body.is_in_group("goomba"):
		emit_signal("right_collision")
