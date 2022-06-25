extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

onready var UI = get_viewport().get_node("Root/UI")   ##Тут ссылаемся на интерфейс
func _on_Button2_pressed():
	$AudioStreamPlayer.play()
	UI.set_allinc()
	UI.save_level()
	get_tree().change_scene("res://Scenes/Root3.tscn")
	pass # Replace with function body.
