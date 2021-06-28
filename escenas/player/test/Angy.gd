extends Area2D

var velocidad = 200
var dirBalaX = 0
var dirBalaY = 0
const SPEEDBALA = 500
var bala = preload("res://escenas/player/bulletAngy.tscn")

func _ready():
	#var balaAngy = bala.instance()
	pass # Replace with function body.

func _process(delta):
	move(delta)
	disparar()


func move(delta):
	if Input.is_action_pressed("A"):
		position.x -= velocidad * delta
		dirBalaX = -SPEEDBALA
	if Input.is_action_pressed("D"):
		position.x += velocidad * delta
		dirBalaX = SPEEDBALA
	if Input.is_action_pressed("W"):
		position.y -= velocidad * delta
		dirBalaY = -SPEEDBALA
	if Input.is_action_pressed("S"):
		position.y += velocidad * delta
		dirBalaY = SPEEDBALA


func disparar():
	if Input.is_action_pressed("disparo"):
		var balaAngy = bala.instance()
		balaAngy.inicio(dirBalaX,dirBalaY)
		get_parent().add_child(balaAngy)
		balaAngy.position = self.position
		
		#Si la bala no esta en movimiento se destruye
		if dirBalaX != 0 or dirBalaY != 0:
			dirBalaX = 0#cancela velocidad en X
			dirBalaY = 0#cancela velocidad en Y
		else: balaAngy.queue_free()
		
#		if Input.is_action_pressed("A"):
#			balaAngy.direccion(-200,0)
#		if Input.is_action_pressed("D"):
#			balaAngy.direccion(200,0)
#		if Input.is_action_pressed("W"):
#			balaAngy.velocidadY = -200
#		if Input.is_action_pressed("S"):
#			balaAngy.velocidadY = 200
		
