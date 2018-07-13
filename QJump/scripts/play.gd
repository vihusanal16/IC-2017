extends Node2D

func _ready():
	set_process(true)
	pass
	
func _process(delta):
	if Input.is_action_pressed("enter"):
		get_tree().change_scene("res://scenes/menu.tscn")


func _on_TouchScreenButton_pressed():
	get_tree().change_scene("res://scenes/menu.tscn")
	pass