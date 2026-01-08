extends Node2D

#Preloading GUI
@onready var options = preload("res://scenes/menu/menu.tscn")
@onready var optionPopup = options.instantiate()
@onready var workshopOpen = false

func _ready():
	#Settings initialization
	add_child(optionPopup)
	optionPopup.position = Vector2i(9000,3000)
	
	#Interface initialization
	$WorkshopZones/shopGUI.visible = false
	
#Settings menu
func _input(event):
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_ESCAPE:
			if Global.menuOpen == false:
				Global.menuOpen = true
				optionPopup.position = Vector2i(Global.res.x/2,Global.res.y/2)
				
			elif Global.menuOpen == true:
				Global.menuOpen = false
				optionPopup.position = Vector2i(9000,3000)

#Opens the workshop interface
func _on_open_workshop_pressed() -> void:
	if !workshopOpen:
		$WorkshopZones/shopGUI.visible = true
		workshopOpen = true
	elif workshopOpen:
		$WorkshopZones/shopGUI.visible = false
		workshopOpen = false
