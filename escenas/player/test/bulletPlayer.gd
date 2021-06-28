extends KinematicBody2D

const speed = 750
var velocity = Vector2()

func start(pos, dir):
	rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Area2D_body_entered(body):
	if body.is_in_group("solid"):
		queue_free();#Se destruye a si mismo
	elif body.is_in_group("enemy"):
		body.queue_free();#Destruye el objeto contrario
		queue_free();#Se autodestruye
		pass
