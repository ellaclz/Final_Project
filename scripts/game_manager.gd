extends Node

var score = 0
var total_coins = 20
var collected_coins = 20


@onready var score_label = $ScoreLabel

func add_point():
	score += 1
	score_label.text = "You collected " + str(score) + "coins."

func collect_coin():
	collected_coins ++ 1
	if collected_coins >= total_coins:
		switch_scene()

func switch_scene():
	var next_scene_path = "res://scenes/level_two.tscn"
	var next_scene = load("res://scenes/level_two.tscn")
	
	if next_scene != null:
		get_tree().get_root().free()
		get_tree().change_scene("res://scenes/level_two.tscn")
		
