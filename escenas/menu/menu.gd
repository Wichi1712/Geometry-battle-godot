extends Control


func _ready():
	OS.center_window()
	globalVar.gameState = "menu"
	pass


func _on_PlayButton_pressed():
	get_tree().change_scene("res://escenas/worlds/world1.tscn")
	globalVar.gameState = "play"


func _on_ExitButton_pressed():
	get_tree().quit()
