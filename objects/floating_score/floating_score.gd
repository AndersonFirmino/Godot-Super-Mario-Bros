extends Node2D


func set_score(value: String) -> void:
	$Label.text = value


func do_floating_effect() -> void:
	global_position.x = global_position.x - 22
	global_position.y = global_position.y - 50
	$Tween.interpolate_property(
		self,
		'position',
		position,
		position - Vector2(0, 60),
		1,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
	)
	$Tween.start()
	yield($Tween, "tween_completed")
	queue_free()
