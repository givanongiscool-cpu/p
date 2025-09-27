extends Area2D
		

func _on_body_entered(body: Node2D) -> void:
	if Body.is_in_group("Main"):
		Body.set_position($Marker2D.global_position)		
	
