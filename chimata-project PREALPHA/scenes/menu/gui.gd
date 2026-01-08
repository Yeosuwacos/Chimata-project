extends Control

func _ready() -> void:
	pass
	
func update(value):
	$Funds.text = "Funds: " + (Global.funds + value).to_string()
