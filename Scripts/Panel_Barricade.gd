extends Control

func _ready():
	pass 


func set_Brick(amount):
	if amount <= 0:
		$Brick.visible = false
		amount = " "
	else:
		$Brick.visible = true
		
	$Label1.text = str(amount)
	
func set_Chain(amount):
	if amount <= 0:
		amount = " "
		$Chain.visible = false
	else:
		$Chain.visible = true
		
	$Label2.text = str(amount)
	
func set_Turrent(amount):
	if amount <= 0:
		amount = " "
		$Turrent.visible = false
	else:
		$Turrent.visible = true
		
	$Label3.text = str(amount)
