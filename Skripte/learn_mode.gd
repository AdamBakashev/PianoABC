extends Control


@onready var click_sound: AudioStreamPlayer = $ButtonClickSound

func _on_learn_mode_pressed():
	click_sound.play()
	get_tree().change_scene_to_file("res://LearnMode.tscn")


func _ready():
	$VBoxContainer/Button.connect("pressed", Callable(self, "_on_entchen_pressed"))
	$VBoxContainer/Button2.connect("pressed", Callable(self, "_on_jingle_pressed"))
	$VBoxContainer/Button3.connect("pressed", Callable(self, "_on_fuchs_pressed"))
	$VBoxContainer/Button4.connect("pressed", Callable(self, "_on_haenschen_pressed"))
	$VBoxContainer/Button5.connect("pressed", Callable(self, "_on_twinkle_pressed"))
	$ZurückZumHauptmenü.connect("pressed", Callable(self, "_on_back_pressed"))
	
	if not MenuMusic.music_player.playing:
		MenuMusic.music_player.play()

func _on_entchen_pressed():
	get_tree().change_scene_to_file("res://Songs/AlleMeineEntchen.tscn")

func _on_jingle_pressed():
	get_tree().change_scene_to_file("res://Songs/JingleBells.tscn")

func _on_fuchs_pressed():
	get_tree().change_scene_to_file("res://Songs/FuchsGans.tscn")

func _on_haenschen_pressed():
	get_tree().change_scene_to_file("res://Songs/HaenschenKlein.tscn")

func _on_twinkle_pressed():
	get_tree().change_scene_to_file("res://Songs/TwinkleStar.tscn")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://MainMenu.tscn")
