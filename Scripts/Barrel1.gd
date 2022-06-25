extends StaticBody2D
var target = null
func _ready():
	var pl = get_parent().get_parent().get_player()
	target = pl
	$Sprite2.visible = false
	



func _on_Area2D_area_entered(area):
	if area.get_parent() == target:
		$Sprite2.visible = true
	for i in get_tree().get_nodes_in_group(GlobalVars.zombi_group):
		if area.get_parent() == i:
			$Sprite2.visible = true 


func _on_Area2D_area_exited(area):
	if area.get_parent() == target:
		$Sprite2.visible = false
	for i in get_tree().get_nodes_in_group(GlobalVars.zombi_group):
		if area.get_parent() == i:
			$Sprite2.visible = false 
