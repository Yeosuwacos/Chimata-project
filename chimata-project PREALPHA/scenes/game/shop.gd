extends Node2D

#Prepares the shop for when it is opened
func _ready():
	$Moves.text = "+10 moves: " + str(floori(Prices.MoreMoves))
	$Bombs.text = "+1 bomb: " + str(floori(Prices.MoreBombs))
	$BombPower.text = "+Bomb power: " + str(floori(Prices.BombPower))

#Buys more moves
func _on_moves_pressed() -> void:
	if Global.funds >= Prices.MoreMoves:
		Global.moves += 10
		Prices.MoreMovesBought += 1
		Prices.MoreMoves += 10*Prices.MoreMovesBought**1.5
		$Moves.text = "+10 moves: " + str(floori(Prices.MoreMoves))

#Buys more bombs
func _on_bombs_pressed() -> void:
	if Global.funds >= Prices.MoreBombs:
		Global.bombQty += 1
		Prices.MoreBombsBought += 1
		Prices.MoreBombs += 100*Prices.MoreBombsBought**1.6
		$Bombs.text = "+1 bomb: " + str(floori(Prices.MoreBombs))

#Increases bomb power
func _on_bomb_power_pressed() -> void:
	if Global.funds >= Prices.BombPower:
		Global.bombStr += 1
		Prices.BombPower += 500*Global.bombStr**3
		$BombPower.text = "+Bomb power: " + str(floori(Prices.BombPower))
