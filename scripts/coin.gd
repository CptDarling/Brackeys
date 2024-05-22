class_name Coin extends Area2D

var value = 1

signal coin_collected(value)

func _on_body_entered(_body: Node2D) -> void:
	print("+1 coin!")
	coin_collected.emit(value)
	queue_free()
