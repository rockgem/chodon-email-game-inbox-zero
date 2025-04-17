extends Node

func _ready() -> void:
	var email = {
			"sender_email": "Heather.HR@BoringCorp.com",
			"sender_name": "Heather Lewis",
			"to": "rock@gmail.com",
			"to_name": "Rock G.",
			"subject": "Ignoring Important Emails",
			"body": "We are deeply concerned about you ignoring important e-mails, to verify your activity, respond to this email immediately!",
			"date": "",
			"type": "hr",
			"on_delete": ["game_over"],
			"on_ignore": ["game_over"],
			"on_reply": ["add_security"],
		}
	ManagerGame.global_main_ref.emails.push_front(email)
	ManagerGame.global_main_ref.ignored_important_letters = 0
	
	queue_free()
