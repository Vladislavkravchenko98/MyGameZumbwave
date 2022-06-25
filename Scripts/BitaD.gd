extends Node2D

#включение коллизии
func bitaon(on):
	if on == true:
		$Area2D/CollisionShape2D.disabled = false
	else:
		$Area2D/CollisionShape2D.disabled = true
	pass
	
	
func _on_Area2D_body_entered(body):
	if "Zombi" in body.name:
		body.kill_barr()
	elif "Barr" in body.name:
		body.kill()
	elif "Barr_L" in body.name:
		body.kill()
	elif "Barr_R" in body.name:
		body.kill()
	elif "Barr_U" in body.name:
		body.kill()
	pass # Replace with function body.
