extends Control

var inc = 0
func _ready():
	$Sprite.visible = false
	pass 
func _process(delta):
	for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
		inc = inc + 1
	if inc == 0:
		$Sprite.visible = false
	inc = 0



func set_arrow(k):
	
	var pl = get_parent().get_parent().get_parent().get_node("Outdoor").get_player()	
	var xp = pl.global_position.x
	var yp = pl.global_position.y
	
	var xz = k.global_position.x
	var yz = k.global_position.y
	
	var region = 400
	
	if((xz <= xp+700 and xz >= xp-700) and (yz <= yp+700 and yz >= yp-700)):
		$Sprite.visible = false
	else:
		$Sprite.visible = true
	
		
	
	
	if(yp+region<yz and xp+region < xz):        #верх права 
		$Sprite.rotation =  (3*3.14)/4
	elif(yp-region>yz and xp+region < xz):                            #вниз вправа
		$Sprite.rotation = (3.14/3)
	elif(yp-region>yz and xp-region > xz):                  #вниз влева
		$Sprite.rotation = -(3.14/3)
	elif(yp+region<yz and xp-region > xz):      #верх лево
		$Sprite.rotation = -(3*3.14)/4
		#По X
	elif(yz <= yp+region and yz >= yp-region and xp < xz) :
		$Sprite.rotation = 33
	elif(yz <= yp+region and yz >= yp-region and xp > xz):
		$Sprite.rotation = -33
		#По Y
	elif(xz <= xp+region and xz >= xp-region and yp < yz):
		$Sprite.rotation = 3.14
	elif(xz <= xp+region and xz >= xp-region and yp > yz):
		$Sprite.rotation = 0

		
	
		
		
func arrow_turnon():
		$Sprite.visible = true
		
func arrow_turnoff():
		$Sprite.visible = false
		

