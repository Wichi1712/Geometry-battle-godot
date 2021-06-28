extends Area2D

var velocidad = 150;
#var direccion = Vector2.ZERO
#var bala = preload("res://escenas/enemy/balaCanon.tscn")
export (PackedScene) var bala
var dir = -velocidad;

func _ready():
	pass

func _process(delta):
	move_local_x(dir * delta, true);
	#move()
	#move2()
	#position += direccion * delta
	#disparar()

#	if Input.is_action_pressed("ui_left"):
#		position.x -= velocidad * delta
#	if Input.is_action_pressed("ui_right"):
#		position.x += velocidad * delta
#	if Input.is_action_pressed("ui_up"):
#		position.y -= velocidad * delta
#	if Input.is_action_pressed("ui_down"):
#		position.y += velocidad * delta
	


#func move():
#	direccion = Vector2.ZERO#actualizamos posicion
#	if Input.is_action_pressed("ui_left"):
#		direccion.x = -1
#	if Input.is_action_pressed("ui_right"):
#		direccion.x = 1
#	if Input.is_action_pressed("ui_up"):
#		move_local_y(-3,true)
#	if Input.is_action_pressed("ui_down"):
#		move_local_y(3,true)
#
#	if direccion.length() > 0:
#		direccion = direccion.normalized() * velocidad


#func move2():
#	if Input.is_action_pressed("ui_left"):
#		move_local_x(-3,true)
#	if Input.is_action_pressed("ui_right"):
#		move_local_x(3,true)
#	if Input.is_action_pressed("ui_up"):
#		move_local_y(-3,true)
#	if Input.is_action_pressed("ui_down"):
#		move_local_y(3,true)


func disparar():
	var balaCuadrado = bala.instance()
	get_parent().add_child(balaCuadrado)
	balaCuadrado.position.x = self.position.x;
	balaCuadrado.position.y = self.position.y - 10;
	
func _on_Cuadrado_area_entered(area):
	if area.is_in_group("enemigo"):
		area.queue_free()#Elimina la instancia contraria
		queue_free()#Se destruye asimismo


func _on_Timer_timeout():
	disparar();


func _on_Canon_body_entered(body):
	if body.is_in_group("solid"):
		if dir == -velocidad: dir = velocidad;
		else: dir = -velocidad;
