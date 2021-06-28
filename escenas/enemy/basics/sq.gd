extends Area2D

var screen_size
export var velocity = Vector2();
var target = Vector2();
#export (int) var speed = 200;
var speed: int = 200
export (PackedScene) var BulletScene;
var puedeDisparar = true;

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	screen_size = get_viewport_rect().size#obtememos el tamaño de ventana
	
	direccion(delta)
	position.x = clamp(position.x,0,screen_size.x)
	position.y = clamp(position.y,0,screen_size.y)
	

func direccion(delta):
	target = get_parent().get_node("player").position;#Vector2(nave)
	
	velocity = position.direction_to(target) * speed
	$spr_sq.look_at(target);#Gira su imagen
	#look_at(target)#gira de acuerdo al objetivo
	if position.distance_to(target) > 100:
		#velocity = move_and_slide(velocity)
		position += velocity * delta
		disparo();
	pass


func disparo():
	if puedeDisparar:
		var bull = BulletScene.instance();
		#Este es un metodo de la escena bullet
		#Esta funcion me permite disparar en la posicion
		#del bulletPosition, es importante que el bulletPosition
		#sea hijo del sprite.
		#La direccion será hacia donde ha rotado su sprite
		bull.start($spr_sq/bulletPosition.global_position, $spr_sq.rotation);
		get_parent().add_child(bull);#Agregamos la instancia a la escena
		puedeDisparar = false;
		$Timer.start(true)#iniciamos la alarma


func _on_Timer_timeout():
	puedeDisparar = true;


func _on_sq_body_entered(body):
	#for body in get_colliding_bodies():
	if body.is_in_group("solid"):
		#speed = -40
		speed = 0
#		#hit_block(body)
#	#elif body.get_name() == "bord_bot":
#		#hit_bot(body)
#		pass
#	else:
#		#hit_regular(body)
#		pass
	pass # Replace with function body.


func _on_sq_body_exited(body):
	speed = 200
	pass # Replace with function body.
