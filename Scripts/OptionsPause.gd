extends Node2D

func _ready():
	var m = mu.get_muon()
	if m == false:
		$Sprite2.visible = false
		$Sprite.visible = true
		#lol = false
	var m2 = mu.get_castle()
	if m2 == 0:
		$Sprite4.visible = false
		$Sprite3.visible = true
	pass 

func _process(delta):
	if mu.get_muon() == false:
		$Sprite2.visible = false
		$Sprite.visible = true
		#lol = false
	else: 
		$Sprite2.visible = true
		$Sprite.visible = false
		#lol = true
		
onready var mu = GlobalMusic

func _on_TouchScreenButton_released():
	if $Sprite2.visible == true:
		$Sprite2.visible = false
		$Sprite.visible = true
		mu.MusicStop(false)
	else:
		$Sprite2.visible = true
		$Sprite.visible = false
		mu.MusicStop(true)
		
	pass # Replace with function body.


func _on_TouchScreenButton2_released():
	if $Sprite4.visible == true:
		$Sprite4.visible = false
		$Sprite3.visible = true
		mu.set_castle(0)
	else:
		$Sprite4.visible = true
		$Sprite3.visible = false
		mu.set_castle(1)
	pass # Replace with function body.
