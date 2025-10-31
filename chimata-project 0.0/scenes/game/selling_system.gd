extends Node2D

#Refreshes the card labels
func _ready():
	$CardSale/Labels/Xs.text += " " + str(Global.sold_xs) + "/" + str(Global.ability_card_xs)
	$CardSale/Labels/S.text += " " + str(Global.sold_s) + "/" + str(Global.ability_card_s)
	$CardSale/Labels/M.text += " " + str(Global.sold_m) + "/" + str(Global.ability_card_m)
	$CardSale/Labels/L.text += " " + str(Global.sold_l) + "/" + str(Global.ability_card_l)
	$CardSale/Labels/Xl.text += " " + str(Global.sold_xl) + "/" + str(Global.ability_card_xl)
