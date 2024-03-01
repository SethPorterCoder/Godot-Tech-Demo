extends Node2D
@onready var coin = 0
@onready var camera = $camera
@onready var player = $Player

func _physics_process(_delta):
	camera.position = player.position
