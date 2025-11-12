extends Node2D

@onready var chimataScene = preload("res://entities/characters/chimata.tscn")
@onready var options = preload("res://scenes/menu/menu.tscn")
@onready var optionPopup = options.instantiate()

func _ready():
	var chimata = chimataScene.instantiate()
	add_child(chimata)
	chimata.position = Vector2i(Global.res.x-50,100*Global.amp)
	
	#Settings initialization
	add_child(optionPopup)
	optionPopup.position = Vector2i(9000,3000)

#Opens the mine shop
func _on_shop_button_pressed() -> void:
	if Global.mShopOpen == false:
		$Shop.position = Vector2(Global.res.x/2,Global.res.y/2)
		Global.mShopOpen = true
		
	elif Global.mShopOpen == true:
		$Shop.position = Vector2(9000,3000)
		Global.mShopOpen = false

func _input(event):
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_ESCAPE:
			if Global.menuOpen == false:
				Global.menuOpen = true
				optionPopup.position = Vector2i(Global.res.x/2,Global.res.y/2)
				
			elif Global.menuOpen == true:
				Global.menuOpen = false
				optionPopup.position = Vector2i(9000,3000)
