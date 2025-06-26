extends Control

@onready var zurueck_button: Button = $ZurueckButton

@onready var key_notes := {
	"C": $Key_C/AudioStreamPlayer,
	"D": $Key_D/AudioStreamPlayer,
	"E": $Key_E/AudioStreamPlayer,
	"F": $Key_F/AudioStreamPlayer,
	"G": $Key_G/AudioStreamPlayer,
	"A": $Key_A/AudioStreamPlayer,
	"B": $Key_B/AudioStreamPlayer
}

var note_names = ["C", "D", "E", "F", "G", "A", "B"]

func _ready():
	zurueck_button.pressed.connect(_on_zurueck_pressed)

func highlight_button(button):
	button.add_theme_color_override("button_color", Color(1, 1, 0.3))
	button.add_theme_color_override("font_color", Color.BLACK)

func reset_button_style(button):
	button.remove_theme_color_override("button_color")
	button.remove_theme_color_override("font_color")

func _on_zurueck_pressed():
	get_tree().change_scene_to_file("res://FreePlay.tscn")
