extends Node

func _ready() -> void:
	var email = {
			"sender_email": "Heather.HR@BoringCorp.com",
			"sender_name": "Heather Lewis",
			"to": "rock@gmail.com",
			"to_name": "Rock G.",
			"subject": "You have been unresponsive",
			"body": "Your co-workers are concerned that you were not responding to their letters. We encourage you to work with the team and contribute",
			"date": "",
			"type": "hr",
			"on_delete": ["reduce_security"],
			"on_ignore": ["reduce_security"],
			"on_reply": ["add_security"],
		}
	ManagerGame.global_main_ref.emails.push_front(email)
	ManagerGame.global_main_ref.ignored_work_letters = 0
	
	queue_free()
