extends KinematicBody2D

var speed = 150
var velocity = Vector2()
export (int) var damage = 20#Daño que causa a player

func start(pos, dir):
	rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		if collision.collider.has_method("hit"):
			collision.collider.hit()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Area2D_body_entered(body):
	if body.is_in_group("solid"):
		queue_free()
#	if body.is_in_group("player"):
#		body.queue_free()
#		queue_free()
