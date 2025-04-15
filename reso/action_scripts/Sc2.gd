extends Node




func _ready() -> void:
	var email = {
			"sender_email": "desire454@hotmail.com",
			"sender_name": "Anonymous",
			"to": "rock@gmail.com",
			"to_name": "Rock G.",
			"subject": "they are not real",
			"body": "do you really know who you are talking to?",
			"date": "UNKNOWN",
			"type": "etc",
			"on_delete": [],
			"on_ignore": [],
			"on_reply": [],
		}
	
	# queues the email for the next specified day
	ManagerGame.emails_data['day_5'].append(email)
	
	queue_free()
