extends Control

@onready var key_notes = {
	"TasteC": $TasteC/AudioStreamPlayer,
	"TasteD": $TasteD/AudioStreamPlayer,
	"TasteE": $TasteE/AudioStreamPlayer,
	"TasteF": $TasteF/AudioStreamPlayer,
	"TasteG": $TasteG/AudioStreamPlayer,
	"TasteA": $TasteA/AudioStreamPlayer,
	"TasteB": $TasteB/AudioStreamPlayer
}

@onready var sprechblase = $Sprechblase

# Neue Song-Reihenfolge
var song_notes = [
	"F", "G", "A", "F", "F", "G", "A", "F",
	"A", "B", "C", "A", "B", "C", "C", "D",
	"C", "B", "A", "F", "C", "D", "C", "B",
	"A", "F", "F", "C", "F", "F", "C", "F"
]

var current_note_index = 0
var last_highlighted = null

func _ready():
	for taste in key_notes.keys():
		var button = get_node(taste)
		button.pressed.connect(_on_key_pressed.bind(taste))
	_update_highlighted_key()

func _on_key_pressed(taste_name):
	var pressed_note = taste_name.replace("Taste", "")
	var expected_note = song_notes[current_note_index]

	if pressed_note == expected_note:
		key_notes[taste_name].play()
		current_note_index += 1
		if current_note_index >= song_notes.size():
			show_congratulations()
			current_note_index = 0
		_update_highlighted_key()
	else:
		key_notes[taste_name].play()

func _update_highlighted_key():
	if last_highlighted != null:
		var old_button = get_node(last_highlighted)
		_reset_button_style(old_button)

	if current_note_index < song_notes.size():
		var note = song_notes[current_note_index]
		var taste_name = "Taste" + note
		sprechblase.text = "Drücke: " + note

		if has_node(taste_name):
			var button = get_node(taste_name)
			button.add_theme_color_override("font_color", Color.BLACK)
			button.add_theme_color_override("button_color", Color(1, 1, 0.3)) # Gelb
			last_highlighted = taste_name
	else:
		sprechblase.text = "🎉 Fertig!"
		last_highlighted = null

func _reset_button_style(button):
	button.remove_theme_color_override("font_color")
	button.remove_theme_color_override("button_color")

func show_congratulations():
	var popup = AcceptDialog.new()
	popup.dialog_text = "🎉 Super! Du hast den neuen Song richtig gespielt!"
	add_child(popup)
	popup.popup_centered()
