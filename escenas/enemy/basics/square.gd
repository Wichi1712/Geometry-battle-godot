extends KinematicBody2D
export (int) var speed = 200
#export (NodePath) var obj_Target
#onready var tgt = get_node(obj_Target)

var target = Vector2()
var velocity = Vector2()
var bulletSQuare = preload("res://escenas/enemy/basics/bulletSquare.tscn")
var puedeDisparar = true


func _physics_process(delta):
#	"""
#	Verifica si la instancia existe
#	Si no existe no se mueve ni dispara
#	"""
	if(is_instance_valid(get_node("../player"))):
		#get_node("../RedBall").moveBall()
		moveDirection(delta)
	

func moveDirection(delta):
	target = get_parent().get_node("player").position#Vector2(nave)
	velocity = position.direction_to(target) * speed
	$Sprite.look_at(target)#gira de acuerdo al target
#	"""
#		Si la distancia al objetivo es mayor a 60 y menor a 400
#		se mueve y dispara"""
	if (position.distance_to(target) < 400):
		shoot()
		#Esto impide que este demasiado pegado al objetivo
		if position.distance_to(target) > 60:
			velocity = move_and_slide(velocity) * delta

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
