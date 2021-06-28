extends Area2D

var dir = Vector2.ZERO
export var velocidad = 200
var screen_size
var objetivo
var giro = 0
export (PackedScene) var BulletScene
#export (PackedScene) var BulletScene

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

func _input(event):
	objetivo = get_global_mouse_position()
	if event.is_action_pressed("mouse_click_izquierdo"):
		disparo()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#screen_size = get_viewport_rect().size#obtememos el tamaño de ventana
	
	direccion(delta)
	position += dir * delta#reposiciona
	$spriteNave.rotation += giro * delta
	
	position.x = clamp(position.x,0,screen_size.x)
	position.y = clamp(position.y,0,screen_size.y)
	
	disparo()
	

func direccion(delta):
	dir = Vector2.ZERO
	$spriteNave.look_at(objetivo)
	#Permite girar solo el sprite de nuestro objeto
	#El nodo de colision mantiene su posicion
	if Input.is_action_pressed("ui_left"):
		giro = -2
	if Input.is_action_pressed("ui_right"):
		giro = 2
	#Permite avanzar o retroceder en direccion hacia donde
	#mira el sprite
	"""
	get_overlapping_bodies().size() == 0 indica que no esta
	colisionando con ningun cuerpo"""
	if Input.is_action_pressed("ui_up") && get_overlapping_bodies().size() == 0:
		dir = Vector2(velocidad,0).rotated($spriteNave.rotation)
	if Input.is_action_pressed("ui_down") && get_overlapping_bodies().size() == 0:
		dir = Vector2(-velocidad,0).rotated($spriteNave.rotation)
	
	
	if dir.length() > 0:
		dir = dir.normalized() * velocidad
	#Al soltar las teclas se detiene el giro
	if Input.is_action_just_released("ui_left"):
		giro = 0

	if Input.is_action_just_released("ui_right"):
		giro = 0
	
	#TECLAS DE DIRECCION
	#get_overlapping_bodies().size() == 0 indica que no esta
	#colisionando con ningun cuerpo
	if Input.is_key_pressed(KEY_A) && get_overlapping_bodies().size() == 0:
		position.x -= velocidad * delta
	if Input.is_key_pressed(KEY_D) && get_overlapping_bodies().size() == 0:
		position.x += velocidad * delta
	if Input.is_key_pressed(KEY_W) && get_overlapping_bodies().size() == 0:
		position.y -= velocidad * delta
	if Input.is_key_pressed(KEY_S) && get_overlapping_bodies().size() == 0:
		position.y += velocidad * delta


func disparo():
	if Input.is_action_pressed("ui_space"):
		var bullet = BulletScene.instance()
		bullet.position = $bulletPosition.global_position
		bullet.start($bulletPosition.global_position, rotation)
		get_parent().add_child(bullet)
		
#		func _on_attack():
#	if Input.is_action_just_pressed("fire"):
#		var bInstance = BulletScene.instance()
#		bInstance.position = $bulletPosition.global_position
#		get_parent().add_child(bInstance)


