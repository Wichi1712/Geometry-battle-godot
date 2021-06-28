extends TileMap

func _ready():
	pass


func shock():
	#queue_free();
	pass


#SOLO PARA PRUEBA
#func colisionPlayer(delta):
#	var collision = move_and_collide(velocity * delta)
#	if collision:
#		#print("ooooooooooooooooooooooooooo")
#		#Cada vez que Dino colisiona con Player llama a su
#		#funcion Shock
#		if collision.collider.has_method("shock"):
#			collision.collider.shock()
#		#Si colisiona con ball en estado Stop
#		if collision.collider.has_method("colisionDino"):
#			collision.collider.colisionDino()
