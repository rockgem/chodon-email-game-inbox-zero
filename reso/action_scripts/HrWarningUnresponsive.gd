extends Node

func _ready() -> void:
	var email = {
			"sender_email": "Heather.HR@BoringCorp.com",
			"sender_name": "Heather Lewis",
			"to": "rock@gmail.com",
			"to_name": "Rock G.",
			"subject": "You have been unresponsive",
			"body": "We are concerned that you are not complying to the company and is not responding to HR. The company has decided to let you go.",
			"date": "",
			"type": "hr",
			"on_delete": ["game_over"],
			"on_ignore": ["game_over"],
			"on_reply": ["game_over"],
		}
	ManagerGame.global_main_ref.emails.push_front(email)
	
	queue_free()
