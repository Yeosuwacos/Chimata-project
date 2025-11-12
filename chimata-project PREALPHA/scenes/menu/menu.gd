extends Control

#Manages the different resolutions available

func _on_x_1080_pressed() -> void:
	Global.res = Vector2i(1920,1080)
	Global.amp = 3
	get_window().size = Vector2i(1920,1080)
	get_window().position = Vector2i(50,50)
	get_tree().reload_current_scene()

func _on_x_720_pressed() -> void:
	Global.res = Vector2i(1280,720)
	Global.amp = 2
	get_window().size = Vector2i(1280,720)
	get_window().position = Vector2i(50,50)
	get_tree().reload_current_scene()


func _on_fullscreen_pressed() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
