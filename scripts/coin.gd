class_name Coin extends Area2D

@onready var animation_player: AnimationPlayer = %AnimationPlayer

var value = 1

signal coin_collected(value)

func _on_body_entered(_body: Node2D) -> void:
	coin_collected.emit(value)
	animation_player.play("pickup")
