extends Area2D


func _on_body_entered(body):
	if(body.id == "player"):
		print("This works")
