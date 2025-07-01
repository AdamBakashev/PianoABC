extends Control

@onready var click_sound: AudioStreamPlayer = $ButtonClickSound



func _ready():
	$VBoxContainer/LearnModeButton.pressed.connect(_on_learn_mode_pressed)
	$VBoxContainer/FreePlayButton.pressed.connect(_on_free_play_pressed)
	$VBoxContainer/ChallengeButton.pressed.connect(_on_challenge_pressed)
	$EinstellungButton.connect("pressed", Callable(self, "_on_einstellung_pressed"))
	
	# Musik starten, falls noch nicht spielend
	if not MenuMusic.music_player.playing:
		MenuMusic.music_player.play()

func _on_learn_mode_pressed():
	get_tree().change_scene_to_file("res://LearnMode.tscn")

func _on_free_play_pressed():
	get_tree().change_scene_to_file("res://FreePlay.tscn")

func _on_challenge_pressed():
	get_tree().change_scene_to_file("res://ChallengeMode.tscn")

func _on_einstellung_pressed():
	get_tree().change_scene_to_file("res://Einstellung.tscn")
