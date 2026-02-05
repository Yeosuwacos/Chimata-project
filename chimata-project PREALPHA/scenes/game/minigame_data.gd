extends Node2D

#Readies the mine layout
@onready var mine = []
@onready var tilemap = get_node("mineWindow/oreMap")
@onready var chimataScene = preload("res://entities/characters/chimata.tscn")
@onready var chimata = chimataScene.instantiate()
@export var ores : Array[Ores]
const tileSize := 128

#Sets the amount of utilities 
@onready var bombs = Global.bombQty
@onready var tps = Global.tpQty
@onready var mults = Global.multQty
@onready var frenzies = Global.frenzyQty

#Calculates the amount of moves Chimata is allowed to do
@onready var moves = Global.moves 

func _ready():
	#Sets the isMining flag to true
	Global.isMining = true
	
	#Loads Chimata in the right spot
	add_child(chimata)
	
	#Makes the camera and the move counter follow chimata
	Global.follow = true
	
	#Places the UI
	$mineWindow/Labels/ResourceBarsLeft.position.y = get_viewport_rect().size.y - $mineWindow/Labels/ResourceBarsLeft.size.y
	$mineWindow/Labels/ResourceBarsRight.position.y = get_viewport_rect().size.y - $mineWindow/Labels/ResourceBarsRight.size.y
	$mineWindow/Labels/ResourceBarsRight.position.x = get_viewport_rect().size.x - $mineWindow/Labels/ResourceBarsRight.size.x
	$mineWindow/Labels/ResourceBarsCenter.position.y = get_viewport_rect().size.y - $mineWindow/Labels/ResourceBarsCenter.size.y
	$mineWindow/Labels/ResourceBarsCenter.position.x = get_viewport_rect().size.x/2 - $mineWindow/Labels/ResourceBarsCenter.size.x/2
	
	$mineWindow/Labels/ResourceBarsLeft/MultStrLeft.value = mults
	if mults != 0:
		$mineWindow/Labels/ResourceBarsLeft/MultStrLeft.max_value = mults
		
	$mineWindow/Labels/ResourceBarsLeft/BombsLeft.value = bombs
	if bombs != 0:
		$mineWindow/Labels/ResourceBarsLeft/BombsLeft.max_value = bombs
		
	$mineWindow/Labels/ResourceBarsRight/TPsLeft.value = tps
	if tps != 0:
		$mineWindow/Labels/ResourceBarsRight/TPsLeft.max_value = tps
		
	$mineWindow/Labels/ResourceBarsRight/FrenziesLeft.value = frenzies
	if frenzies != 0:
		$mineWindow/Labels/ResourceBarsRight/FrenziesLeft.max_value = frenzies
	
	#Creates the mine as a 2D grid
	#Places down every tile correctly
	
	for i in 100:
		mine.append([])
		for j in 500:
			mine[i].append(0)
			tilemap.set_cell(Vector2i(i, j), 1, Vector2i(0, 0))
	
	#Goes through the mine again to place down the ores
	for i in 100:
		for j in 500:
			var pos = Vector2i(i,j)
			
			for ore in ores:
				if ore.minimum <= j && j <= ore.maximum && randf() < 0.025*ore.chance:
					placeOres(pos,ore.type)

	#Places Chimata at the top of the mine
	tilemap.set_cell(Vector2i(50, 0), -1)
	mine[50][0] = 0
	
#Makes an inventory for all ores collected
@onready var ore_xs = 0
@onready var ore_s = 0
@onready var ore_m = 0
@onready var ore_l = 0
@onready var ore_xl = 0

#Generates clumps of ores (flood fill algorithm)
func placeOres(startPos: Vector2i, type: int):
	var size = randi_range(1,12)
	
	var unfinished = [startPos]
	var finished = {}
	
	while unfinished.size() > 0 && size > 0:
		var pos = unfinished.pop_front()
		if pos.x < 0 || pos.x >= 100 || pos.y < 0 || pos.y >= 500:
			continue
		if finished.has(pos):
			continue
		if mine[pos.x][pos.y] != 0:
			continue
		tilemap.set_cell(pos, 1, Vector2i(type, 0))
		mine[pos.x][pos.y] = type
		finished[pos] = true
		size -= 1
		
		#Looks around the tile to generate veins
		unfinished.append(pos + Vector2i(1,0))
		unfinished.append(pos + Vector2i(0,1))
		unfinished.append(pos + Vector2i(-1,0))
		unfinished.append(pos + Vector2i(0,-1))

#Gets the current tile Chimata is on
func getTile():
	return Vector2i(int(chimata.position.x/128), int(chimata.position.y/128))

#Gets the tile Chimata is hovering on
func hoverTile():
	var tile = getTile()
	var offset = Vector2i(int(round(chimata.orient.x)),int(round(chimata.orient.y)))
	return tile + offset

#Turns Chimata's orientation into an axis
func direct():
	var orient = chimata.orient
	if abs(orient.x) > abs(orient.y):
		return Vector2i(sign(orient.x),0)
	else:
		return Vector2i(0,sign(orient.y))

#Detects where Chimata is going to check which ore she picks up
#Removes the ore from the mine
#Uses special items if needed

func _physics_process(delta):
	#Makes sure that you cant go out of bounds
	if moves > 0 && Global.isMining == true:
		#Mining
		if Input.is_action_just_pressed("confirm"):
			var target = hoverTile()
			if mineTile(target,Global.addActive):
				moves -= 1
			$mineWindow/Labels/ResourceBarsCenter.position.x = get_viewport_rect().size.x/2 - $mineWindow/Labels/ResourceBarsCenter.size.x/2
		#Special actions
		if Input.is_action_just_pressed("bomb") && bombs > 0:
			var bombSignal = false
			var chimataPos = getTile()
			for i in range(-Global.bombStr,Global.bombStr+1):
				for j in range(-Global.bombStr, Global.bombStr+1):
					var pos = chimataPos + Vector2i(i,j)
					if mineTile(pos, Global.add):
						bombSignal = true
			if bombSignal == true:
				bombs -= 1
				moves -= 1
				$mineWindow/Labels/ResourceBarsLeft/BombsLeft.value -= 1
				
		if Input.is_action_just_pressed("tp") && tps > 0:
			var tpSignal = false
			var tilePos = getTile()
			var y = tilePos.y + Global.tpStr
			if y < 500:
				tps -= 1
				mineTile(Vector2i(tilePos.x,Global.tpStr),Global.addActive)
				chimata.position.y += 128*Global.tpStr
				$mineWindow/Labels/ResourceBarsRight/TPsLeft.value -= 1
				
		if Input.is_action_just_pressed("addStr") && mults > 0 && Global.addActive == false:
			Global.addActive = true
			mults -= 1
			$mineWindow/Labels/ResourceBarsLeft/MultStrLeft.value -= 1
				
		if Input.is_action_just_pressed("frenzy") && frenzies > 0:
			var frenzySignal = false
			var chimataPos = getTile()
			var direction = direct()
			
			for i in range(1, Global.frenzyStr + 1):
				var pos = chimataPos + direction * i
				var beamW = Vector2i(-direction.y, direction.x)
				
				for j in [-1, 0, 1]:
					var point = pos + beamW * j
					if mineTile(point, Global.addActive):
						frenzySignal = true
			if frenzySignal == true:
				frenzies -= 1
				moves -= 1
				$mineWindow/Labels/ResourceBarsRight/FrenziesLeft.value -= 1
	#Brings up the minigame end screen (stats and button)
	elif moves <= 0:
		endGame()
		
#Executes multiple mining operations
func mineTile(pos,mult):
	pos.x = clamp(pos.x,0,99)
	pos.y = clamp(pos.y,0,99)
	
	#Mines the tile depending on value
	var tileVal = mine[pos.x][pos.y]
	if tileVal == 0:
		return false

	addOre(tileVal,mult)
	mine[pos.x][pos.y] = 0
	tilemap.set_cell(pos,-1)
	return true

#Adds the corresponding ore and multiplier
func addOre(nb,mult):
	var strength = 1
	if mult == true:
		strength = Global.multStr
		
	match nb:
		1: ore_xs += strength
		2: ore_s += strength
		3: ore_m += strength
		4: ore_l += strength
		5: ore_xl += strength
		
	Global.addActive = false

#Ends the mining session and returns to the surface
func _on_back_pressed() -> void:
	Global.follow = false
	#Updates ores available
	Global.dragon_gem_xs += ore_xs
	Global.dragon_gem_s += ore_s
	Global.dragon_gem_m += ore_m
	Global.dragon_gem_l += ore_l
	Global.dragon_gem_xl += ore_xl
	queue_free()
	get_tree().call_deferred("change_scene_to_file", "res://scenes/game/mines.tscn")

#Ends the mining game early
func _on_back_early_pressed() -> void:
	endGame()

#Displays statistics and offers to go back to the surface
func endGame():
	Global.isMining = false
	
	#Displays surface
	$mineWindow/Labels/returnSurface.visible = true
	$mineWindow/Labels/returnSurface/Stats.text = "You mined:\r" + str(ore_xs) + " dragon gem dust\r" \
	+ str(ore_s) + " dragon gem pieces\r" + str(ore_m) + " dragon gems\r" + str(ore_l) \
	+ " dragon gem chunks\r" + str(ore_xl) + " dragon gem clusters" 

func _exit_tree():
	Save.saveGame()
