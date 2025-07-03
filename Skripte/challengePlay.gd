extends Control

@onready var sprechblase: Label = $Sprechblase
@onready var level_label: Label = $LevelLabel
@onready var ready_button: Button = $ReadyButton
@onready var zurueck_button: Button = $ZurueckButton
@onready var fail_sound: AudioStreamPlayer = $FailSound  # <-- Hinzugefügt

@onready var key_notes := {
	"C": $Key_C/AudioStreamPlayer,
	"D": $Key_D/AudioStreamPlayer,
	"E": $Key_E/AudioStreamPlayer,
	"F": $Key_F/AudioStreamPlayer,
	"G": $Key_G/AudioStreamPlayer,
	"A": $Key_A/AudioStreamPlayer,
	"H": $Key_H/AudioStreamPlayer,
	"C5": $Key_C5/AudioStreamPlayer,
}

var note_names = ["C", "D", "E", "F", "G", "A", "H"]
var level_lengths = [5, 7, 9, 12, 15]
var level_speeds = [1.0, 0.9, 0.75, 0.6, 0.45]

var current_level = 0
var current_note_index = 0
var player_input_enabled = false
var song = []
var mode = "intro" # "intro", "input"

func _ready():
	ready_button.pressed.connect(_on_ready_pressed)
	zurueck_button.pressed.connect(_on_zurueck_pressed)

	for note in key_notes.keys():
		var button = get_node("Key_" + note)
		button.pressed.connect(_on_key_pressed.bind(note))
		button.focus_mode = Control.FOCUS_NONE

	update_level_label()
	start_level()
	
	if MenuMusic.music_player.playing:
		MenuMusic.music_player.stop()

func update_level_label():
	level_label.text = "Aktuelles Level: %d" % (current_level + 1)

func start_level():
	player_input_enabled = false
	current_note_index = 0
	song = generate_melodic_sequence(level_lengths[current_level])
	sprechblase.text = "Level%d Bereit?" % (current_level + 1)
	update_level_label()
	mode = "intro"
	ready_button.show()

func _on_ready_pressed():
	ready_button.hide()
	await play_song_intro()

func play_song_intro():
	sprechblase.text = "🎵Hör zu..."
	for note in song:
		var button = get_node("Key_" + note)
		highlight_button(button)
		key_notes[note].play()
		await get_tree().create_timer(level_speeds[current_level]).timeout
		reset_button_style(button)
	await get_tree().create_timer(0.5).timeout
	current_note_index = 0
	sprechblase.text = "Jetzt selber spielen!"
	player_input_enabled = true
	mode = "input"

func _on_key_pressed(note: String):
	if not player_input_enabled:
		return

	var expected_note = song[current_note_index]

	if note != expected_note:
		fail_sound.play()  # <-- Fehlersound abspielen
		sprechblase.text = "❌Falsch! Zurück zu Level 1"
		player_input_enabled = false
		current_level = 0
		await get_tree().create_timer(2.0).timeout
		start_level()
		return

	key_notes[note].play()
	current_note_index += 1

	if current_note_index >= song.size():
		player_input_enabled = false
		if current_level == level_lengths.size() - 1:
			sprechblase.text = "🎉Du hast den Challenge Modus geschafft!"
		else:
			current_level += 1
			sprechblase.text = "✅Richtig! Weiter zu Level %d" % (current_level + 1)
			await get_tree().create_timer(2.0).timeout
			start_level()

func highlight_button(button):
	button.add_theme_color_override("button_color", Color(1, 1, 0.3))
	button.add_theme_color_override("font_color", Color.BLACK)

func reset_button_style(button):
	button.remove_theme_color_override("button_color")
	button.remove_theme_color_override("font_color")
	
func _on_zurueck_pressed():
	get_tree().change_scene_to_file("res://ChallengeMode.tscn")

func generate_melodic_sequence(length: int) -> Array:
	var melody := []
	var index = randi() % note_names.size()
	var last_note = ""
	var repeat_count = 0

	for i in length:
		var current_note = note_names[index]

		if current_note == last_note:
			repeat_count += 1
		else:
			repeat_count = 1
			last_note = current_note

		if repeat_count > 3:
			var step = 1 if randi() % 2 == 0 else -1
			index = clamp(index + step, 0, note_names.size() - 1)
			current_note = note_names[index]
			repeat_count = 1
			last_note = current_note

		melody.append(current_note)

		var step = [ -1, 1, 1, 0, 1 ][randi() % 5]
		index = clamp(index + step, 0, note_names.size() - 1)

	return melody
