extends Control

func _ready():
	$VBoxContainer/LearnModeButton.pressed.connect(_on_learn_mode_pressed)
	$VBoxContainer/FreePlayButton.pressed.connect(_on_free_play_pressed)
	$VBoxContainer/ChallengeButton.pressed.connect(_on_challenge_pressed)

func _on_learn_mode_pressed():
	get_tree().change_scene_to_file("res://LearnMode.tscn")

func _on_free_play_pressed():
	get_tree().change_scene_to_file("res://FreePlay.tscn")

func _on_challenge_pressed():
	get_tree().change_scene_to_file("res://ChallengeMode.tscn")
