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

@onready var sprechblase: Label = $Sprechblase
@onready var zurueck_button: Button = $ZurueckButton

var song_notes = [
	"C", "D", "E", "F", "G", "G",
	"A", "A", "A", "A", "G",
	"A", "A", "A", "A", "G",
	"F", "F", "F", "F", "E",
	"E", "G", "G", "G", "G", "C"
]

var current_note_index = 0
var last_highlighted = null

func _ready():
	for key in key_notes.keys():
		var button = get_node(key)
		button.pressed.connect(_on_key_pressed.bind(key))
		_reset_button_style(button)
	_update_highlighted_key()
	
	zurueck_button.pressed.connect(_on_zurueck_pressed)
	
	if MenuMusic.music_player.playing:
		MenuMusic.music_player.stop()

func _input(event):
	if event is InputEventKey and event.pressed:
		for key_name in key_notes.keys():
			if Input.is_action_just_pressed(key_name):
				print("Input action pressed: ", key_name)
				_on_key_pressed(key_name)


func _on_key_pressed(key_name):
	var expected_note = song_notes[current_note_index]
	var pressed_note = key_name.replace("Key_", "")
	
	var player = key_notes[key_name]
	if player.playing:
		player.stop()
	player.play()
	
	if pressed_note == expected_note:
		current_note_index += 1
		if current_note_index >= song_notes.size():
			show_congratulations()
			current_note_index = 0
	_update_highlighted_key()
	

func _update_highlighted_key():
	for key in key_notes.keys():
		var button = get_node(key)
		_reset_button_style(button)
	
	if current_note_index < song_notes.size():
		var note = song_notes[current_note_index]
		var highlight_key = "Key_" + note
		if has_node(highlight_key):
			var highlight_button = get_node(highlight_key)
			highlight_button.add_theme_color_override("font_color", Color.BLACK)
			highlight_button.add_theme_color_override("button_color", Color(1, 1, 0.5)) # Gelb
		sprechblase.text = "Drücke:" + note
	else:
		sprechblase.text = "🎉 Fertig!"
		last_highlighted = null

func _reset_button_style(button):
	button.remove_theme_color_override("font_color")
	button.remove_theme_color_override("button_color")

func show_congratulations():
	var popup = AcceptDialog.new()
	popup.dialog_text = "🎉 Super! Du hast 'Alle meine Entchen' gespielt!"
	add_child(popup)
	popup.popup_centered()

func _on_zurueck_pressed():
	get_tree().change_scene_to_file("res://LearnMode.tscn")
