extends Control

func set_amount(amount, all):
	$Label.text = str(amount) + "/" + str(all)
	
	
func icon_item():                        #Pistol
	if $Pistol.visible == true:
		$Pistol.visible = false
		$Hand.visible = true
		$Baseballbat.visible = false
		for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
			i.gun_model(0, false)
	elif $Hand.visible == true:                                 #Hand
		$Pistol.visible = false
		$Hand.visible = false
		$Baseballbat.visible = true
		for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
			i.gun_model(2, false)
	elif $Baseballbat.visible == true:
		$Pistol.visible = true
		$Hand.visible = false
		$Baseballbat.visible = false
		for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
			i.gun_model(1, true)
	
