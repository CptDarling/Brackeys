#class_name GameManager
extends Node

var score: int = 0
var stats = {}

const VERSION: String = "0.0.1"
@onready var STATS_FILENAME = "user://stats.json"

const STATS_VERSION = "Version"
const STAT_SCORE = "lifetime_score"
const STAT_DEAD = "lifetime_deaths"
const STAT_GAMES_PLAYED = "games_played"

func _ready() -> void:
	_load()
	_prepare_stats()


func _prepare_stats() -> void:
	if !STATS_VERSION in stats: stats[STATS_VERSION] = VERSION
	if !STAT_GAMES_PLAYED in stats: stats[STAT_GAMES_PLAYED] = 0
	if !STAT_SCORE in stats: stats[STAT_SCORE] = 0
	if !STAT_DEAD in stats: stats[STAT_DEAD] = 0


func add_points(points: int) -> void:
	score += points
	stats[STAT_SCORE] += points
	_save()
	print_debug("coin collected worth a value of ", points, ", total score is ", score)


# Reset the current run stats
func reset() -> void:
	score = 0
	stats[STAT_GAMES_PLAYED] += 1
	_save()
	print_debug(stats)


## Record player death to permanent stats
func player_died() -> void:
	stats[STAT_DEAD] += 1
	_save()


func _save() -> void:
	var save_file = FileAccess.open(STATS_FILENAME, FileAccess.WRITE)
	save_file.store_line(JSON.stringify(stats))
	save_file.close()


func _load() -> void:
	if !FileAccess.file_exists(STATS_FILENAME):
		print_debug("Stats file not found, creating new file: ", STATS_FILENAME)
		return

	var save_file = FileAccess.open(STATS_FILENAME, FileAccess.READ)

	while save_file.get_position() < save_file.get_length():
		var json = JSON.new()

		# get the only dictionary in the stats file
		json.parse(save_file.get_line())

		# get the data
		stats = json.get_data()

	save_file.close()

	if STATS_VERSION in stats:
		if stats[STATS_VERSION] != VERSION:
			stats = {}
			print_debug("unknown version of stats file: ", STATS_FILENAME)
