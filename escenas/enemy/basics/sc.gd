extends Area2D

var screen_size
export var velocity = Vector2();
var target = Vector2();
export (int) var speed = 200;
export (PackedScene) var BulletScene;
var puedeDisparar = true;

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	screen_size = get_viewport_rect().size#obtememos el tamaño de ventana
	
	direccion(delta)
	
	position.x = clamp(position.x,0,screen_size.x)
	position.y = clamp(position.y,0,screen_size.y)
	
	

func direccion(delta):
	target = get_parent().get_node("player").position;#Vector2(nave)
	
	velocity = position.direction_to(target) * speed
	$Sprite.look_at(target)
	if position.distance_to(target) > 100:
		#velocity = move_and_slide(velocity)
		position += velocity * delta
		disparo();
	pass


func disparo():
	if puedeDisparar:
		var bull = BulletScene.instance()
		#Este es un metodo de la escena bullet
		#Esta funcion me permite disparar en la posicion
		#del bulletPosition, es importante que el bulletPosition
		#sea hijo del sprite.
		#La direccion será hacia donde ha rotado su sprite
		bull.start($Sprite/bulletPosition.global_position, $Sprite.rotation);
		get_parent().add_child(bull)
		puedeDisparar = false
		$Timer.start(true)#iniciamos la alarma
		
#		func _on_attack():
#	if Input.is_action_just_pressed("fire"):
#		var bInstance = BulletScene.instance()
#		bInstance.position = $BulletPosition.global_position
#		get_parent().add_child(bInstance)




func _on_Timer_timeout():
	puedeDisparar = true;
