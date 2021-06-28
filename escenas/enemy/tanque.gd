extends Area2D

var velocidad = 300
#var direccion = Vector2.ZERO
#var bala = preload("res://escenas/enemy/balaCanon.tscn")
export (PackedScene) var bala
var dir = -velocidad

func _ready():
	pass

func _process(delta):
	move_local_x(dir * delta, true)



func disparar():
	var balaCuadrado = bala.instance()
	get_parent().add_child(balaCuadrado)
	balaCuadrado.position.x = self.position.x
	balaCuadrado.position.y = self.position.y - 25
	

func _on_Timer_timeout():
	disparar()



func _on_tanque_area_entered(area):
	if area.is_in_group("enemigo"):
		area.queue_free()#Elimina la instancia contraria
		queue_free()#Se destruye asimismo


func _on_tanque_body_entered(body):
	if body.is_in_group("solid"):
		if dir == -velocidad: dir = velocidad
		else: dir = -velocidad
