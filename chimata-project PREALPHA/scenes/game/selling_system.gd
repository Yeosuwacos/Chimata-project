extends Node2D

#Refreshes the card labels
func _ready():
	$CardSale/Buttons/AddRem/Xs.text = "Lesser ability cards " + str(Global.sold_xs) + "/" + str(Global.ability_card_xs)
	$CardSale/Buttons/AddRem/S.text = "Ability cards " + str(Global.sold_s) + "/" + str(Global.ability_card_s)
	$CardSale/Buttons/AddRem/M.text = "Greater ability cards " + str(Global.sold_m) + "/" + str(Global.ability_card_m)
	$CardSale/Buttons/AddRem/L.text = "Quest ability cards " + str(Global.sold_l) + "/" + str(Global.ability_card_l)
	$CardSale/Buttons/AddRem/Xl.text = "Special ability cards " + str(Global.sold_xl) + "/" + str(Global.ability_card_xl)
	
	#Adjusts Sakuya's scale
	$Bartering/HigherLower/Sakuya.scale = Vector2(400.0/$Bartering/HigherLower/Sakuya.texture.get_width(), \
	500.0/$Bartering/HigherLower/Sakuya.texture.get_height())

#Adding or removing cards for sale

#Xs
func _on_add_xs_pressed() -> void:
	if Global.sold_xs < Global.ability_card_xs:
		Global.sold_xs += 1
		$CardSale/Buttons/AddRem/Xs.text = "Lesser ability cards " + str(Global.sold_xs) + "/" + str(Global.ability_card_xs)

func _on_rem_xs_pressed() -> void:
	if Global.sold_xs > 0:
		Global.sold_xs -= 1
		$CardSale/Buttons/AddRem/Xs.text = "Lesser ability cards " + str(Global.sold_xs) + "/" + str(Global.ability_card_xs)

#S
func _on_add_s_pressed() -> void:
	if Global.sold_s < Global.ability_card_s:
		Global.sold_s += 1
		$CardSale/Buttons/AddRem/S.text = "Ability cards " + str(Global.sold_s) + "/" + str(Global.ability_card_s)

func _on_rem_s_pressed() -> void:
	if Global.sold_s > 0:
		Global.sold_s -= 1
		$CardSale/Buttons/AddRem/S.text = "Ability cards " + str(Global.sold_s) + "/" + str(Global.ability_card_s)

#M
func _on_add_m_pressed() -> void:
	if Global.sold_m < Global.ability_card_m:
		Global.sold_m += 1
		$CardSale/Buttons/AddRem/M.text = "Greater ability cards " + str(Global.sold_m) + "/" + str(Global.ability_card_m)

func _on_rem_m_pressed() -> void:
	if Global.sold_m > 0:
		Global.sold_m -= 1
		$CardSale/Buttons/AddRem/M.text = "Greater ability cards " + str(Global.sold_m) + "/" + str(Global.ability_card_m)

#L
func _on_add_l_pressed() -> void:
	if Global.sold_l < Global.ability_card_l:
		Global.sold_l += 1
		$CardSale/Buttons/AddRem/L.text = "Quest ability cards " + str(Global.sold_l) + "/" + str(Global.ability_card_l)

func _on_rem_l_pressed() -> void:
	if Global.sold_l > 0:
		Global.sold_l -= 1
		$CardSale/Buttons/AddRem/L.text = "Quest ability cards " + str(Global.sold_l) + "/" + str(Global.ability_card_l)

#Xl
func _on_add_xl_pressed() -> void:
	if Global.sold_xl < Global.ability_card_xl:
		Global.sold_xl += 1
		$CardSale/Buttons/AddRem/Xl.text = "Special ability cards " + str(Global.sold_xl) + "/" + str(Global.ability_card_xl)

func _on_rem_xl_pressed() -> void:
	if Global.sold_xl > 0:
		Global.sold_xl -= 1
		$CardSale/Buttons/AddRem/Xl.text = "Special ability cards " + str(Global.sold_xl) + "/" + str(Global.ability_card_xl)

#Selling the desired cards without bartering
func _on_sell_pressed() -> void:
	var total = 0
	total += (Global.sold_xs * 50 + Global.sold_s * 300 + Global.sold_m * \
	825 + Global.sold_l * 2150 + Global.sold_xl * 5400)
	remove_stock()
	sell(total)

#Bartering interface (minigames)

#Higher-lower minigame
func _on_hi_lo_pressed() -> void:
	var total = 0
	total += (Global.sold_xs * 50 + Global.sold_s * 300 + Global.sold_m * \
	825 + Global.sold_l * 2150 + Global.sold_xl * 5400)
	if total > 0:
		$CardSale.position = Vector2(9000,3000)
		HigherLower(total)

func HigherLower(wager):
	$Bartering/HigherLower.position = Vector2(900,300)
	Global.wager = wager
	Global.nb1 = randi_range(3,10)
	Global.nb2 = randi_range(1,12)
	
	#Makes sure the two numbers arent equal
	while Global.nb2 == Global.nb1:
		Global.nb2 = randi_range(1,12)
	
	$Bartering/HigherLower/Card1.text = str(Global.nb1)
	
#Variables for the higher-lower minigame
func _on_higher_pressed() -> void:
	$Bartering/HigherLower/Card2.text = str(Global.nb2)
	if Global.nb1 < Global.nb2:
		Global.wager *= 1.25
		$Bartering/HigherLower/Card2.text += ": Win!"
	elif Global.nb1 > Global.nb2:
		Global.wager *= 0.75
		$Bartering/HigherLower/Card2.text += ": Lose!"
	$Bartering/Cashout.position = Vector2(900,268)

func _on_lower_pressed() -> void:
	$Bartering/HigherLower/Card2.text = str(Global.nb2)
	if Global.nb1 > Global.nb2:
		Global.wager *= 1.25
		$Bartering/HigherLower/Card2.text += ": Win!"
	elif Global.nb1 < Global.nb2:
		Global.wager *= 0.75
		$Bartering/HigherLower/Card2.text += ": Lose!"
	$Bartering/Cashout.position = Vector2(900,268)

#Blackjack minigame
func _on_blackjack_pressed() -> void:
	var total = 0
	total += (Global.sold_xs * 50 + Global.sold_s * 300 + Global.sold_m * \
	825 + Global.sold_l * 2150 + Global.sold_xl * 5400)
	if total > 0:
		$CardSale.position = Vector2(9000,3000)
		Blackjack(total)
		
func Blackjack(wager):
	$Bartering/Blackjack.position = Vector2(900,300)
	Global.wager = wager
	var starterCard1 = randi_range(1,10)
	var starterCard2 = randi_range(1,10)
	Global.playerHand = starterCard1 + starterCard2
	Global.marisaHand = starterCard1 + starterCard2
	$Bartering/Blackjack/PlayerNb.text = str(Global.playerHand)
	$Bartering/Blackjack/OpponentNb.text = str(Global.marisaHand)
	$Bartering/Blackjack/BlCards/YourCards.add_child(BlDisplayCard(starterCard1))
	$Bartering/Blackjack/BlCards/YourCards.add_child(BlDisplayCard(starterCard2))
	$Bartering/Blackjack/BlCards/MarisaCards.add_child(BlDisplayCard(starterCard1))
	$Bartering/Blackjack/BlCards/MarisaCards.add_child(BlDisplayCard(starterCard2))
	
#Hitting adds a card while doubling down adds two and ends the turn
	
func _on_hit_pressed() -> void:
	if Global.playerHand < 21:
		var drawnCard = randi_range(1,10)
		Global.playerHand += drawnCard
		$Bartering/Blackjack/PlayerNb.text = str(Global.playerHand)
		$Bartering/Blackjack/BlCards/YourCards.add_child(BlDisplayCard(drawnCard))
		checkBust()
	
func _on_d_down_pressed() -> void:
	$Bartering/Blackjack/DDown.disabled = true
	if Global.playerHand < 21:
		var drawnCard1 = randi_range(1,13)
		var drawnCard2 = randi_range(1,13)
		Global.playerHand += drawnCard1
		Global.playerHand += drawnCard2
		$Bartering/Blackjack/PlayerNb.text = str(Global.playerHand)
		$Bartering/Blackjack/BlCards/YourCards.add_child(BlDisplayCard(drawnCard1))
		$Bartering/Blackjack/BlCards/YourCards.add_child(BlDisplayCard(drawnCard2))
		checkBust()

func _on_stand_pressed() -> void:
	disable()
	while Global.marisaHand < 17:
		var drawnCard =  randi_range(1,13)
		Global.marisaHand += drawnCard
		$Bartering/Blackjack/OpponentNb.text = str(Global.marisaHand)
		$Bartering/Blackjack/BlCards/MarisaCards.add_child(BlDisplayCard(drawnCard))
		
	if Global.marisaHand == Global.playerHand:
		$Bartering/Blackjack/PlayerNb.text += " - Draw!"
		
	elif Global.marisaHand < Global.playerHand || Global.marisaHand > 21: 
		$Bartering/Blackjack/PlayerNb.text += " - Win!"
		Global.wager *= 1.5
		
	else: 
		$Bartering/Blackjack/PlayerNb.text += " - Lose!"
		Global.wager *= 0.5
	$Bartering/Cashout.position = Vector2(900,268)

func checkBust():
	if Global.playerHand > 21:
		$Bartering/Blackjack/PlayerNb.text += " - Bust!"
		Global.wager *= 0.5
		disable()
		$Bartering/Cashout.position = Vector2(900,268)
	elif Global.playerHand == 21:
		$Bartering/Blackjack/PlayerNb.text += " - Blackjack!"
		Global.wager *= 1.5
		disable()
		$Bartering/Cashout.position = Vector2(900,268)
	elif $Bartering/Blackjack/DDown.disabled == true:
		_on_stand_pressed()
		
#Creating and matching the right card to the sprites for display
func BlDisplayCard(cardNo):
	var card = TextureRect.new()
	var png = null
	match cardNo:
		1: png = load("res://assets/game elements/BlCards/ace_of_spades.png")
		2: png = load("res://assets/game elements/BlCards/2_of_spades.png")
		3: png = load("res://assets/game elements/BlCards/3_of_spades.png")
		4: png = load("res://assets/game elements/BlCards/4_of_spades.png")
		5: png = load("res://assets/game elements/BlCards/5_of_spades.png")
		6: png = load("res://assets/game elements/BlCards/6_of_spades.png")
		7: png = load("res://assets/game elements/BlCards/7_of_spades.png")
		8: png = load("res://assets/game elements/BlCards/8_of_spades.png")
		9: png = load("res://assets/game elements/BlCards/9_of_spades.png")
		10: png = load("res://assets/game elements/BlCards/10_of_spades.png")
		11: png = load("res://assets/game elements/BlCards/jack_of_spades.png")
		12: png = load("res://assets/game elements/BlCards/queen_of_spades.png")
		13: png = load("res://assets/game elements/BlCards/king_of_spades.png")
	card.texture = png
	return card

#Disables the buttons
func disable():
	$Bartering/Blackjack/Hit.disabled = true
	$Bartering/Blackjack/DDown.disabled = true
	$Bartering/Blackjack/Stand.disabled = true

#Confirming a sale and updating the amount
func sell(total):
	Global.funds += total
	$GUI/Funds.text = "Funds: " + str(floori(Global.funds))
	$Bartering/HigherLower.position = Vector2(9000,3000)
	$Bartering/Blackjack.position = Vector2(9000,3000)

#Removing the sold items/secondary variables
func remove_stock():
	Global.ability_card_xs -= Global.sold_xs
	Global.ability_card_s -= Global.sold_s
	Global.ability_card_m -= Global.sold_m
	Global.ability_card_l -= Global.sold_l
	Global.ability_card_xl -= Global.sold_xl
	
	Global.sold_xs = 0
	Global.sold_s = 0
	Global.sold_m = 0
	Global.sold_l = 0
	Global.sold_xl = 0
	
	$Bartering/HigherLower/Card1.text = ""
	$Bartering/HigherLower/Card2.text = ""
	
	$CardSale/Buttons/AddRem/Xs.text = "Lesser ability cards " + str(Global.sold_xs) + "/" + str(Global.ability_card_xs)
	$CardSale/Buttons/AddRem/S.text = "Ability cards " + str(Global.sold_s) + "/" + str(Global.ability_card_s)
	$CardSale/Buttons/AddRem/M.text = "Greater ability cards " + str(Global.sold_m) + "/" + str(Global.ability_card_m)
	$CardSale/Buttons/AddRem/L.text = "Quest ability cards " + str(Global.sold_l) + "/" + str(Global.ability_card_l)
	$CardSale/Buttons/AddRem/Xl.text = "Special ability cards " + str(Global.sold_xl) + "/" + str(Global.ability_card_xl)

#Ends the bartering process
func _on_cashout_pressed() -> void:
	remove_stock()
	sell(ceili(Global.wager))
	$Bartering/Cashout.position = Vector2(9000,3000)
	$Bartering/Blackjack/Hit.disabled = false
	$Bartering/Blackjack/Stand.disabled = false
	$Bartering/Blackjack/DDown.disabled = false
	$CardSale.position = Vector2(50,50)
	var removeYourHand = $Bartering/Blackjack/BlCards/YourCards.get_children()
	var removeMarisaHand = $Bartering/Blackjack/BlCards/MarisaCards.get_children()
	discard(removeYourHand)
	discard(removeMarisaHand)

#Clears up the cards (visually)
func discard(hand):
	for card in hand:
		card.queue_free()
