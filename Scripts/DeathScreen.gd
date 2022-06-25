extends Control

#func _ready():
	#var b = $Button
	#b.connect("pressed", self, "change_stage", [b.scene_to_open])

#func change_stage(path):
	#SceneChanger.change_scene(path)

var Rus = 0
func _ready():
	var data = Fs.load_data('Player_saves.txt')
	Rus = data.Rus
	if Rus == 1:
		$Button/Label2.visible = false
		$Sprite/Label2.visible = false
		
		$Button/Label.visible = true
		$Sprite/Label.visible = true
		$Sprite/Label3.visible = true
		$Sprite/Label5.visible = true
		$Sprite/Label6.visible = true
	else:
		$Button/Label.visible = false
		$Sprite/Label.visible = false
		$Sprite/Label3.visible = false
		$Sprite/Label5.visible = false
		$Sprite/Label6.visible = false
		
		$Button/Label2.visible = true
		$Sprite/Label2.visible = true
	pass # Replace with function body.
