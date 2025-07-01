extends Node

var music_player: AudioStreamPlayer

func _ready():
	music_player = AudioStreamPlayer.new()
	add_child(music_player)

	var stream = preload("res://Sound/MenuMusik-15.12.48.ogg") as AudioStreamOggVorbis
	stream.loop = true  # Hier ist das Looping korrekt
	music_player.stream = stream

	music_player.volume_db = -6
	music_player.play()
