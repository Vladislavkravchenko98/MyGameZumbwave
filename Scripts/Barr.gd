extends "res://Scripts/Men2D.gd"

func _ready():
	speed = 60
	self.hp = 100
	self.max_hp = 100
	set_start_hp(self.hp, self.max_hp)
	add_to_group(GlobalVars.zombi_group)
	toggle_hp_bar()
