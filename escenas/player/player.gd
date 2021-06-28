extends KinematicBody2D

export var velocidad = 350
var giro = 0
var dir = Vector2.ZERO
var move = Vector2()
var tamanoPantalla
var puedeDisparar = true
#export (PackedScene) var BulletScene

var bullet = preload("res://escenas/player/bulletPlayer.tscn")

func _ready():
	tamanoPantalla = get_viewport_rect().size
	

func _physics_process(delta):
	#PRUEBA DE MOVIMIENTO
	#Esto permite que solo gire su sprite
	$Sprite.rotation +=giro * delta
	
	move = move_and_slide(move)
	giro = 0#Esta es otra manera de cancelar el giro
	
	movimiento()
	disparo()
	
	#Limites de movimiento horizontal y vertical
	position.x = clamp(position.x, 0, tamanoPantalla.x)
	position.y = clamp(position.y, 0, tamanoPantalla.y)

func movimiento():
	dir = Vector2.ZERO
	move = Vector2()#Se encarga de detener movimiento
	
	if(Input.is_action_pressed("ui_up")):
		move = Vector2(velocidad, 0).rotated($Sprite.rotation)
	if(Input.is_action_pressed("ui_down")):
		move = Vector2(-velocidad, 0).rotated($Sprite.rotation)
	if(Input.is_action_pressed("ui_left")):
		giro = -2
	if(Input.is_action_pressed("ui_right")):
		giro = 2
		
	if(dir.length() > 0):
		dir = dir.normalized() * velocidad
	
	#PRUEBA DE MOVIMIENTO
#	if(Input.is_action_pressed("W")):
#		move = Vector2(velocidad, 0).rotated($Sprite.rotation)
#		#$Sprite.rotate(rotation)
#	if(Input.is_action_pressed("S")):
#		move = Vector2(-velocidad, 0).rotated($Sprite.rotation)
#		#$Sprite.rotate(rotation)
#	if(Input.is_action_pressed("A")):
#		giro = -1.5
#	if(Input.is_action_pressed("D")):
#		giro = 1.5
	

	#Esta es una manera de cancelar el giro
#	if Input.is_action_just_released("ui_left"):
#		giro = 0
#	if Input.is_action_just_released("ui_right"):
#		giro = 0

func disparo():
	if Input.is_action_pressed("ui_space") && puedeDisparar:
		var bull = bullet.instance()
		#Este es un metodo de la escena bulletSquare
		#$posBullet es un nodo tipo position2D
		bull.start($Sprite/BulletPosition.global_position, $Sprite.rotation)
		get_parent().add_child(bull)
		puedeDisparar = false
		$Timer.start()


func _on_Timer_timeout():
	puedeDisparar = true
