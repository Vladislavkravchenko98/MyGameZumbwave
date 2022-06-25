extends "res://Scripts/Men2D.gd"


func _ready():
	add_to_group(GlobalVars.barricade_group)
	add_to_group(GlobalVars.barricade_chain_group)
	self.hp = 100
	self.max_hp = 100
	set_start_hp(self.hp, self.max_hp)
	toggle_hp_bar()

### Передвижение и поиск игрока
func _process(delta):
	if self.hp <= 0:
		queue_free()

func kill():
		reduce_hp(25)            
		if self.hp <= 0:
			queue_free()
