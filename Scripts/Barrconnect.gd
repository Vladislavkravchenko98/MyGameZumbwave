extends Node2D
##############ПРОВЕРКА МОЖНО ЛИ ПОСТВИТЬ БАРРИКАДУ 1
onready var g = get_node("Barr1contact/CollisionShape2D")
onready var g2 = get_node("Barr1contactU/CollisionShape2D")
onready var g3 = get_node("Barr1contactL/CollisionShape2D")
onready var g4 = get_node("Barr1contactR/CollisionShape2D")

var t = false
var b = 0
var inc = 0
var a2 = true #Нужна для борьбы с багом (BIGREADBUTTON)
#func _process(delta):
	#if($Barr1GreenD.visible == true or $Barr1GreenL.visible == true or $Barr1GreenU.visible == true or $Barr1GreenR.visible == true):
		#for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				#i.set_Barr1(true)
	#else:
		#for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
			#	i.set_Barr1(false)
	#pass

func set_inc(u):
	inc = u
func set_barr1contact(a):
	a2 = a
	if a == true:
		t = true
		for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_t(t)
				i.set_Barr1(true)
		if (inc == 2):      #вниз
			b = 2
			for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_b(b)
			g.disabled = false
			$Barr1GreenD.visible = true
			$GreenD.visible = true
		elif (inc == 1):
			b = 1
			for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_b(b)
			g2.disabled = false
			$Barr1GreenU.visible = true
			$GreenU.visible = true
		elif(inc == 3):
			b = 3
			for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_b(b)
			g3.disabled = false
			$Barr1GreenL.visible = true
			$GreenL.visible = true
		elif(inc == 4):
			b = 4
			for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_b(b)
			g4.disabled = false
			$Barr1GreenR.visible = true
			$GreenR.visible = true
	else:
		t = false
		for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_t(t)
				i.set_Barr1(false)
		g.disabled = true
		g2.disabled = true
		g3.disabled = true
		g4.disabled = true
		$Barr1GreenD.visible = false
		$Barr1GreenU.visible = false
		$Barr1GreenL.visible = false
		$Barr1GreenR.visible = false
		
		$GreenL.visible = false
		$GreenD.visible = false
		$GreenR.visible = false
		$GreenU.visible = false
		
		$RedL.visible = false
		$RedD.visible = false
		$RedR.visible = false
		$RedU.visible = false

func _on_Barr1contact_area_entered(area):
	
	if "Castle" in area.name:
		var tyyyy = 0
	else:
		for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
					i.set_Barr1(false)
		$GreenD.visible = false
		$RedU.visible = false
		$RedD.visible = true
	
	pass # Replace with function body.
func _on_Barr1contact_area_exited(area):
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_Barr1(true)
	if(g.disabled == false):
		$RedD.visible = false
		$RedU.visible = false
		$GreenD.visible = true
	pass # Replace with function body.
		

func _on_Barr1contactU_area_entered(area):
	if "Castle" in area.name:
		var tyyyy = 0
	else:
		for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
					i.set_Barr1(false)
		if a2 == true:
			$RedU.visible = true
		$GreenU.visible = false
	pass # Replace with function body.
func _on_Barr1contactU_area_exited(area):
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_Barr1(true)
	if(g2.disabled == false):
		$RedU.visible = false
		$GreenU.visible = true
	pass # Replace with function body.



func _on_Barr1contactR_area_entered(area):
	if "Castle" in area.name:
		var tyyyy = 0
	else:
		for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
					i.set_Barr1(false)
		$RedR.visible = true
		$RedU.visible = false
		$GreenR.visible = false
	pass # Replace with function body.
func _on_Barr1contactR_area_exited(area):
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_Barr1(true)
	if(g4.disabled == false):
		$RedR.visible = false
		$RedU.visible = false
		$GreenR.visible = true
	pass # Replace with function body.




func _on_Barr1contactL_area_entered(area):
	if "Castle" in area.name:
		var tyyyy = 0
	else:
		for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
					i.set_Barr1(false)
		$RedL.visible = true
		$RedU.visible = false
		$GreenL.visible = false
	pass # Replace with function body.
func _on_Barr1contactL_area_exited(area):
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_Barr1(true)
	if(g3.disabled == false):
		$RedL.visible = false
		$RedU.visible = false
		$GreenL.visible = true
	pass # Replace with function body. """
