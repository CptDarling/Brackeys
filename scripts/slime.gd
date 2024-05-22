extends Node2D

const SPEED = 60
const LEFT = -1
const RIGHT = 1

var direction = RIGHT

@onready var ray_cast_right: RayCast2D = %RayCastRight
@onready var ray_cast_left: RayCast2D = %RayCastLeft
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D

func _process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		direction = LEFT
		animated_sprite_2d.flip_h = true
	if ray_cast_left.is_colliding():
		direction = RIGHT
		animated_sprite_2d.flip_h = false

	position.x += SPEED * direction * delta
