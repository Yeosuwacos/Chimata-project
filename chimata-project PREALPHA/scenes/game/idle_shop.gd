extends Node2D

#Prepares the idle shop for when it is opened
func _ready():
	$IdleShopGrid/idlerXsText.text = "+1 xs/s: " + str(floori(Prices.idleXs))
	$GUI.position.y = $IdleShopGrid.size.y
	$GUI/Funds.text = "Funds: " + str(floori(Global.funds))
	
#Buys idle harvesters
func _on_idler_xs_pressed() -> void:
	if Global.funds >= Prices.idleXs:
		Global.funds -= Prices.idleXs
		Global.idleXs += 1
		Prices.idleXsBought += 1
		Prices.idleXs += 100*Prices.idleXsBought**1.6
		$IdleShopGrid/idlerXsText.text = "+1 xs/s: " + str(floori(Prices.idleXs))
		$GUI/Funds.text = "Funds: " + str(floori(Global.funds))
