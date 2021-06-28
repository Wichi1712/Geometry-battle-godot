extends CanvasLayer

#export (NodePath) var playerNode
#onready var player = get_node(playerNode)

func _process(_delta):
	#$TextureProgress.value = player.health
	$TextureProgress.value = globalVar.playerEnergy
