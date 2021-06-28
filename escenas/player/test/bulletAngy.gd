extends Area2D

var velocidadX = 0
var velocidadY = 0
var direccion = Vector2.ZERO

func _ready():
	#direccion = Vector2(velocidadX,velocidadY)
	#Ocultar el CanvasItem si está visible actualmente.
	#hide()
	
	
#	if Input.is_action_pressed("ui_space"):
#		if Input.is_action_pressed("A"):
#			velocidadX = -200
#		if Input.is_action_pressed("D"):
#			velocidadX = 200
#		if Input.is_action_pressed("W"):
#			velocidadY = -200
#		if Input.is_action_pressed("S"):
#			velocidadY = 200
	pass



func inicio(velX, velY):
	velocidadX = velX
	velocidadY = velY


func _process(delta):
	#position += 10
	direccion = Vector2(velocidadX,velocidadY)
	translate(direccion * delta)
	#print("posicion es: " + String( position))

#Se elimina si sale de la pantalla
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
