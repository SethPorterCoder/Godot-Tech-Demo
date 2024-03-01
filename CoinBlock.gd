extends Area2D



func _on_body_entered(body):
	if(body.id == "player"):
		print("Nonsignal block");
		self.get_parent().coin = self.get_parent().coin + 1;
		queue_free();
