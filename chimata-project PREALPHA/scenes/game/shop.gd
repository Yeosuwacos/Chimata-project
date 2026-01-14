extends Node2D

#Prepares the shop for when it is opened
func _ready():
	$ShopGrid/MovesText.text = "+25  moves: " + str(floori(Prices.MoreMoves))
	$ShopGrid/MultText.text = "+1 ore multiplier: " + str(floori(Prices.MoreMoves))
	$ShopGrid/MultStrText.text = "+1 multiplier strength: " + str(floori(Prices.Mult))
	$ShopGrid/BombsText.text = "+1 bomb: " + str(floori(Prices.MoreBombs))
	$ShopGrid/BombPowerText.text = "+Bomb power: " + str(floori(Prices.BombPower))
	$ShopGrid/TPsText.text = "+1 teleport: " + str(floori(Prices.MoreTPs))
	$ShopGrid/TPpowerText.text = "+5 teleport power: " + str(floori(Prices.TPpower))
	$GUI.position.y = $ShopGrid.size.y
	$GUI/Funds.text = "Funds: " + str(floori(Global.funds))

#Buys more moves
func _on_moves_pressed() -> void:
	if Global.funds >= Prices.MoreMoves:
		Global.funds -= Prices.MoreMoves
		Global.moves += 25
		Prices.MoreMovesBought += 1
		Prices.MoreMoves += 10*Prices.MoreMovesBought**1.5
		$ShopGrid/MovesText.text = "+25 moves: " + str(floori(Prices.MoreMoves))
		$GUI/Funds.text = "Funds: " + str(floori(Global.funds))

#Buys more multipliers
func _on_mult_pressed() -> void:
	if Global.funds >= Prices.Mult:
		Global.funds -= Prices.Mult
		Global.multQty += 1
		Prices.MultBought += 1
		Prices.Mult += 50*Prices.MultBought**1.7
		$ShopGrid/MultText.text = "+1 ore multiplier: " + str(floori(Prices.Mult))
		$GUI/Funds.text = "Funds: " + str(floori(Global.funds))
		
#Increases multiplier strength
func _on_mult_str_pressed() -> void:
	if Global.funds >= Prices.MultStr:
		Global.funds -= Prices.MultStr
		Global.multStr += 1
		Prices.MultStr += 100*Prices.MultStr**1.9
		$ShopGrid/MultStrText.text = "+1 multiplier strength: " + str(floori(Prices.MultStr))
		$GUI/Funds.text = "Funds: " + str(floori(Global.funds))

#Buys more bombs
func _on_bombs_pressed() -> void:
	if Global.funds >= Prices.MoreBombs:
		Global.funds -= Prices.MoreBombs
		Global.bombQty += 1
		Prices.MoreBombsBought += 1
		Prices.MoreBombs += 100*Prices.MoreBombsBought**1.6
		$ShopGrid/BombsText.text = "+1 bomb: " + str(floori(Prices.MoreBombs))
		$GUI/Funds.text = "Funds: " + str(floori(Global.funds))

#Increases bomb power
func _on_bomb_power_pressed() -> void:
	if Global.funds >= Prices.BombPower:
		Global.funds -= Prices.BombPower
		Global.bombStr += 1
		Prices.BombPower += 500*Global.bombStr**3
		$ShopGrid/BombPowerText.text = "+Bomb power: " + str(floori(Prices.BombPower))
		$GUI/Funds.text = "Funds: " + str(floori(Global.funds))

#Buys more TPs
func _on_t_ps_pressed() -> void:
	if Global.funds >= Prices.MoreTPs:
		Global.funds -= Prices.MoreTPs
		Global.tpQty += 1
		Prices.MoreTPsBought += 1
		Prices.MoreTPs += 200*Prices.MoreTPsBought**1.9
		$ShopGrid/TPsText.text = "+1 teleport: " + str(floori(Prices.MoreTPs))
		$GUI/Funds.text = "Funds: " + str(floori(Global.funds))

func _on_t_ppower_pressed() -> void:
	if Global.finds >= Prices.MoreTPs:
		Global.funds -= Prices.MoreTPs
		Global.tpStr += 5
		Prices.TPpower += 300*Prices.TPpower**2.5
		$ShopGrid/TPpower.text = "+5 teleport power: " + str(floori(Prices.TPpower))
		$Gui/Funds.text = "FUnds: " + str(floori(Global.funds))
