extends Control


func _ready():
	OS.center_window();
	globalVar.gameState = "menu";
	pass


func _on_PlayButton_pressed():
	get_tree().change_scene("res://escenas/main/principal.tscn");
	globalVar.stateGame = "play";
	pass # Replace with function body.


func _on_ExitButton_pressed():
	get_tree().quit();
