extends Control

@onready var key_notes = {
	"Key_C": $Key_C/AudioStreamPlayer,
	"Key_D": $Key_D/AudioStreamPlayer,
	"Key_E": $Key_E/AudioStreamPlayer,
	"Key_F": $Key_F/AudioStreamPlayer,
	"Key_G": $Key_G/AudioStreamPlayer,
	"Key_A": $Key_A/AudioStreamPlayer,
	"Key_B": $Key_B/AudioStreamPlayer,
	"Key_C5": $Key_C5/AudioStreamPlayer,
}

@onready var zurueck_button: Button = $ZurueckButton

func _ready():
	for key in key_notes.keys():
		var button = get_node(key)
		button.pressed.connect(_on_key_pressed.bind(key))
	zurueck_button.pressed.connect(_on_zurueck_pressed)
	
	if MenuMusic.music_player.playing:
		MenuMusic.music_player.stop()

func _on_key_pressed(key_name):
	var player = key_notes[key_name]
	if player.playing:
		player.stop()
	player.play()

func _on_zurueck_pressed():
	get_tree().change_scene_to_file("res://FreePlay.tscn")
