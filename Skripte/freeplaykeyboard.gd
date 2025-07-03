extends Control

@onready var key_notes = {
	"Key_C": $Key_C/AudioStreamPlayer,
	"Key_D": $Key_D/AudioStreamPlayer,
	"Key_E": $Key_E/AudioStreamPlayer,
	"Key_F": $Key_F/AudioStreamPlayer,
	"Key_G": $Key_G/AudioStreamPlayer,
	"Key_A": $Key_A/AudioStreamPlayer,
	"Key_H": $Key_H/AudioStreamPlayer,
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
	
	var button = get_node(key_name)
	_change_button_font_color(button, true)
	
	await get_tree().create_timer(0.15).timeout
	_change_button_font_color(button, false)

func _input(event):
	for action_name in key_notes.keys():
		if Input.is_action_just_pressed(action_name):
			var player = key_notes[action_name]
			if player.playing:
				player.stop()
			player.play()
			
			var button = get_node(action_name)
			_change_button_font_color(button, true)
				
			await get_tree().create_timer(0.15).timeout
			_change_button_font_color(button, false)
func _change_button_font_color(button: Button, pressed: bool) -> void:
	if pressed:
		button.add_theme_color_override("font_color", Color.BLACK)
	else:
		button.remove_theme_color_override("font_color")

func _on_zurueck_pressed():
	get_tree().change_scene_to_file("res://FreePlay.tscn")
