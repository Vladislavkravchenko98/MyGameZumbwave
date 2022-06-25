extends Node2D


func _ready():
	$AudioStreamPlayer.play()
	pass 
	
var muon = true
func MusicStop(lol):
	if lol == false:
		muon = false
		$AudioStreamPlayer.stop()
	else: 
		muon = true
		$AudioStreamPlayer.play()


func get_muon():
	return muon


#### Для информации о указатели на castle
var cast = 1
func set_castle(ab2):
	cast = ab2
	
func get_castle():
	return cast
