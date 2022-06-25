extends Node2D
##############ПРОВЕРКА МОЖНО ЛИ ПОСТВИТЬ БАРРИКАДУ 1
onready var g = get_node("Barr2contact/CollisionShape2D")
onready var g2 = get_node("Barr2contactU/CollisionShape2D")
onready var g3 = get_node("Barr2contactL/CollisionShape2D")
onready var g4 = get_node("Barr2contactR/CollisionShape2D")
var a2 = true
var t = false
var b = 0
var inc = 0
#func _process(delta):
	#if($Barr1GreenD.visible == true or $Barr1GreenL.visible == true or $Barr1GreenU.visible == true or $Barr1GreenR.visible == true):
		#for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				#i.set_Barr2(true)
	#else:
		#for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				#i.set_Barr2(false)
	#pass

func set_inc(u):       #Если inc меняется, то нужно менять направление (b передаем для того же)
	inc = u
func set_barr3contact(a):
	a2 = a
	if a == true:
		t = true
		for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_t3(t)
				i.set_Barr3(true)
		if (inc == 2):      #вниз
			b = 2
			for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_b3(b)
			g.disabled = false
			$D1.visible = true
			$D2.visible = true
			$GreenD.visible = true
		elif (inc == 1):
			b = 1
			for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_b3(b)
			g2.disabled = false
			$U1.visible = true
			$U2.visible = true
			$GreenU.visible = true
		elif(inc == 3):
			b = 3
			for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_b3(b)
			g3.disabled = false
			$L1.visible = true
			$L2.visible = true
			$GreenL.visible = true
		elif(inc == 4):
			b = 4
			for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_b3(b)
			g4.disabled = false
			$R1.visible = true
			$R2.visible = true
			$GreenR.visible = true
	else:
		t = false
		for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_t3(t)
				i.set_Barr3(false)
		g.disabled = true
		g2.disabled = true
		g3.disabled = true
		g4.disabled = true
		$D1.visible = false
		$U1.visible = false
		$L1.visible = false
		$R1.visible = false
		$D2.visible = false
		$U2.visible = false
		$L2.visible = false
		$R2.visible = false
		
		$GreenL.visible = false
		$GreenD.visible = false
		$GreenR.visible = false
		$GreenU.visible = false
		
		$RedL.visible = false
		$RedD.visible = false
		$RedR.visible = false
		$RedU.visible = false
		

func _on_Barr2contact_area_entered(area):
	if "Castle" in area.name:
		var tyyyy = 0
	else:
		for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
					i.set_Barr3(false)
		$GreenD.visible = false
		$RedU.visible = false
		$RedD.visible = true
	
	pass # Replace with function body.
func _on_Barr2contact_area_exited(area):
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_Barr3(true)
	if(g.disabled == false):
		$RedD.visible = false
		$RedU.visible = false
		$GreenD.visible = true
	pass # Replace with function body.
		

func _on_Barr2contactU_area_entered(area):
	if "Castle" in area.name:
		var tyyyy = 0
	else:
		for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
					i.set_Barr3(false)
		if a2 == true:
			$RedU.visible = true
		$GreenU.visible = false
	pass # Replace with function body.
func _on_Barr2contactU_area_exited(area):
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_Barr3(true)
	if(g2.disabled == false):
		$RedU.visible = false
		$GreenU.visible = true
	pass # Replace with function body.



func _on_Barr2contactR_area_entered(area):
	if "Castle" in area.name:
		var tyyyy = 0
	else:
		for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
					i.set_Barr3(false)
		$RedR.visible = true
		$RedU.visible = false
		$GreenR.visible = false
	pass # Replace with function body.
func _on_Barr2contactR_area_exited(area):
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_Barr3(true)
	if(g4.disabled == false):
		$RedR.visible = false
		$RedU.visible = false
		$GreenR.visible = true
	pass # Replace with function body.




func _on_Barr2contactL_area_entered(area):
	if "Castle" in area.name:
		var tyyyy = 0
	else:
		for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
					i.set_Barr3(false)
		$RedL.visible = true
		$RedU.visible = false
		$GreenL.visible = false
	pass # Replace with function body.
func _on_Barr2contactL_area_exited(area):
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
				i.set_Barr3(true)
	if(g3.disabled == false):
		$RedL.visible = false
		$RedU.visible = false
		$GreenL.visible = true
	pass # Replace with function body. 
