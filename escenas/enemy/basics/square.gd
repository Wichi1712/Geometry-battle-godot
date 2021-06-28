extends KinematicBody2D
export (int) var speed = 200

var target = Vector2()
var velocity = Vector2()
var bulletSQuare = preload("res://escenas/enemy/basics/bulletSquare.tscn")
var puedeDisparar = true


func _physics_process(delta):
	"""
	Verifica si la instancia existe
	Si no existe no se mueve ni dispara
	"""
	if(is_instance_valid(get_node("../playerTest"))):
		#get_node("../RedBall").moveBall()
		moveDirection(delta);
	

func moveDirection(delta):
	target = get_parent().get_node("playerTest").position;#Vector2(nave)
	velocity = position.direction_to(target) * speed
	$Sprite.look_at(target)#gira de acuerdo al mouse
	if position.distance_to(target) < 400:
		velocity = move_and_slide(velocity) * delta
		shoot()

func shoot():
	if puedeDisparar:
		var bull = bulletSQuare.instance()
		bull.start($Sprite/bulletPosition.global_position, $Sprite.rotation)
		get_parent().add_child(bull)
		puedeDisparar = false
		$Timer.start(true)#iniciamos la alarma


func _on_Timer_timeout():
	puedeDisparar = true
	#$Timer.start()
