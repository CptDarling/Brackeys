extends Node2D

@onready var coins: Node = %Coins
@onready var score_label: Label = %ScoreLabel

func _ready() -> void:

	# set current local score to zero
	GameManager.reset()

	# be notified when coins are collected
	for coin: Coin in coins.get_children():
		coin.coin_collected.connect(_on_coin_collected)


func _on_coin_collected(value: int) -> void:
	# the game manager is tracking the score
	GameManager.add_points(value)

	# update the UI
	_update_ui()


func _update_ui() -> void:
	score_label.text = "You collected " + str(GameManager.score) + " coins"
