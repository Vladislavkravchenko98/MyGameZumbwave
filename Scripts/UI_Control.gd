extends Control
onready var pack = $Panel
##Вкл и выкл инвенторя
func toggle_inventory(inventory):
	if pack.visible:
		pack.clear()
		pack.visible = false
	else:
		pack.visible = true
		pack.show_inventory(inventory)

func update_inventory(inventory):
	if pack.visible:
		pack.show_inventory(inventory)
		
		
func set_death_screen():
	$Panel.hide()
	$DeathScreen.show()
	

