extends Node2D

@onready var chimataScene = preload("res://entities/characters/chimata.tscn")
@onready var options = preload("res://scenes/menu/menu.tscn")
@onready var optionPopup = options.instantiate()
@onready var shopSize = Vector2(1280,450)
@onready var momoyoSize = Vector2(360,450)

func _ready():
	var chimata = chimataScene.instantiate()
	add_child(chimata)
	chimata.position = Vector2i(Global.res.x-50,get_viewport_rect().size.y - shopSize.y - 64)
	
	#Settings/GUI initialization
	add_child(optionPopup)
	optionPopup.position = Vector2i(9000,3000)
	$ShopGUI/BG.size = shopSize
	$ShopGUI/BG.position = Vector2(0, get_viewport_rect().size.y - shopSize.y)
	
	#Momoyo initialization
	$ShopGUI/Momoyo.scale = momoyoSize/$ShopGUI/Momoyo.texture.get_size()
	$ShopGUI/Momoyo.position = Vector2(momoyoSize.x/2, get_viewport_rect().size.y - momoyoSize.y/2)
	
	#Hides the shop until the button is pressed
	$ShopGUI.visible = false

#Opens the mine shop
func _on_shop_button_pressed() -> void:
	if Global.mShopOpen == false:
		#Creates random dialogue
		$Shop/mDialogue.text = Dialogue.mineShopLines.pick_random()
		$ShopGUI.visible = true
		$Shop.position = Vector2(Global.res.x/2,Global.res.y/2)
		Global.mShopOpen = true
		
	elif Global.mShopOpen == true:
		$Shop.position = Vector2(9000,3000)
		$ShopGUI.visible = false
		Global.mShopOpen = false
		
#Opens the idle shop
func _on_idle_shop_button_pressed() -> void:
	if Global.iShopOpen == false:
		$IdleShop.position = Vector2(Global.res.x/2,Global.res.y/2)
		Global.iShopOpen = true
		
	elif Global.iShopOpen == true:
		$IdleShop.position = Vector2(9000,3000)
		Global.iShopOpen = false

func _input(event):
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_ESCAPE:
			if Global.menuOpen == false:
				Global.menuOpen = true
				optionPopup.position = Vector2i(Global.res.x/2,Global.res.y/2)
				
			elif Global.menuOpen == true:
				Global.menuOpen = false
				optionPopup.position = Vector2i(9000,3000)
