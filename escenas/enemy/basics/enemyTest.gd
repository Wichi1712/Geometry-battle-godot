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

#func seguirMouse():
	#target = get_global_mouse_position()


func _on_Timer_timeout():
	puedeDisparar = true
	#$Timer.start()


#func _on_Area2D_body_entered(body):
#	if body.is_in_group("bulletPlayer"):
#		#queue_free()
#		#hit_block(body)
#		pass
#	elif body.get_name() == "bord_bot":
#		#hit_bot(body)
#		pass
#	else:
#		#hit_regular(body)
#		pass
#	pass # Replace with function body.

#func hit_block(body):
#	body.queue_free()
#	break_s.play()
#	if body.get_parent().get_child_count() == 1:
#		print("GANA")
#		you_win_s.play()
#		get_tree().paused = true
#		yield(you_win_s,"finished")
#		queue_free()
#		var replay_scn = load("res://title/replay.tscn")
#		get_parent().add_child(replay_scn.instance())
#
#func hit_bot(body):
#	print("PIERDE")
#	get_tree().paused = true
#	lose_s.play()
#	yield(lose_s,"finished")
#	queue_free()
#	var replay_scn = load("res://title/replay.tscn")
#	get_parent().add_child(replay_scn.instance())
#
#func hit_regular(body):
#	hit_s.play()
