extends Sprite

var coin_up_speed = 0.20
var coin_y_animation = 60
var coin_y_erased = 40

func coin_animation():
	SFX.coin()
	$Tween.interpolate_property(
		self,
		'position',
		position,
		position - Vector2(0, coin_y_animation),
		coin_up_speed,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
	)
	$Tween.start()
	yield($Tween, "tween_completed")
	$Tween.interpolate_property(
		self,
		'position',
		position,
		position - Vector2(0, -coin_y_erased),
		coin_up_speed,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
	)
	$Tween.start()
	yield($Tween, "tween_completed")
	queue_free()

func _ready():
	coin_animation()
