extends Control

var Rus = 0
func _ready():
	$Anim.play("Coins")
	var data = Fs.load_data('Player_saves.txt')
	Rus = data.Rus
	if Rus == 1:
		$Label.visible = false
		$Labelrus.visible = true
	else:
		$Labelrus.visible = false
		$Label.visible = true
	pass 

var coins = 0
func set_amount(amount):
	coins = coins + amount
	if coins >= 100000 and coins < 1000000:
		$Label.rect_position.x = -626
		$Labelrus.rect_position.x = -604
	elif coins >= 1000000:
		$Label.rect_position.x = -673
		$Labelrus.rect_position.x = -646
	$Label.text = "COINS/" + str(coins)
	$Labelrus.text = "Монет/" + str(coins)
	
func get_amount():
	return coins


