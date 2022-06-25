extends Node2D

func update_label(value):
	get_node("UI/Control/Counter").text = "Items: %s" % str(value)

func _ready():
	var pl = $Outdoor.get_player()
	pl.connect("on_death", $UI/Control, "set_death_screen", [])


#Сохранение данных и загрузка
#func save_level():
	#Fs.save_data('Player_saves.txt',{
		#'key' : 'val'
	#})
	#pass
	
#var value_coins = null
#func load_level():
	#var data = Fs.load_data('Player_saves.txt')
	#value_coins = data.key
	#pass
