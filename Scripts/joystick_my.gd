extends Node2D


func _ready():
	pass # Replace with function body.






func _on_R_pressed():
	$SpriteR.visible = true
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_walking(true)
	pass # Replace with function body.


func _on_L_pressed():
	$SpriteL.visible = true
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_walking(true)
	pass # Replace with function body.


func _on_U_pressed():
	$SpriteU.visible = true
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_walking(true)
	pass # Replace with function body.


func _on_D_pressed():
	$SpriteD.visible = true
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_walking(true)
	pass # Replace with function body.


func _on_R_released():
	$SpriteR.visible = false
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
			i.set_walking(false)
	pass # Replace with function body.


func _on_L_released():
	$SpriteL.visible = false
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_walking(false)
	pass # Replace with function body.


func _on_U_released():
	$SpriteU.visible = false
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_walking(false)
	pass # Replace with function body.


func _on_D_released():
	$SpriteD.visible = false
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_walking(false)
	pass # Replace with function body.
	
	
	
#################################################################################2
func _on_R2_pressed():
	$SpriteR.visible = true
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_walking(true)
	pass # Replace with function body.


func _on_L2_pressed():
	$SpriteL.visible = true
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_walking(true)
	pass # Replace with function body.


func _on_U2_pressed():
	$SpriteU.visible = true
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_walking(true)
	pass # Replace with function body.


func _on_D2_pressed():
	$SpriteD.visible = true
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_walking(true)
	pass # Replace with function body.


func _on_R2_released():
	$SpriteR.visible = false
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
			i.set_walking(false)
	pass # Replace with function body.


func _on_L2_released():
	$SpriteL.visible = false
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_walking(false)
	pass # Replace with function body.


func _on_U2_released():
	$SpriteU.visible = false
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_walking(false)
	pass # Replace with function body.


func _on_D2_released():
	$SpriteD.visible = false
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_walking(false)
	pass # Replace with function body.

