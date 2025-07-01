extends Node2D

func _ready() -> void:
	$ZurückZumHauptmenü.connect("pressed", Callable(self, "_on_back_pressed"))
	$SpielenButton.connect("pressed", Callable(self, "_on_spielen_pressed"))
	
	if not MenuMusic.music_player.playing:
		MenuMusic.music_player.play()


func _on_back_pressed():
	get_tree().change_scene_to_file("res://MainMenu.tscn")

func _on_spielen_pressed():
	get_tree().change_scene_to_file("res://ChallengePlay.tscn")
#
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
