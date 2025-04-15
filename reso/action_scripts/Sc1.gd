extends Node



func _ready() -> void:
	var email = {
			"sender_email": "desire454@hotmail.com",
			"sender_name": "Anonymous",
			"to": "rock@gmail.com",
			"to_name": "Rock G.",
			"subject": "don't you want to know what happened?",
			"body": "31st floor Room 13.",
			"date": "UNKNOWN",
			"type": "etc",
			"on_delete": ["run_script", "res://reso/action_scripts/sc2.tscn"],
			"on_ignore": ["run_script", "res://reso/action_scripts/sc2.tscn"],
			"on_reply": ["run_script", "res://reso/action_scripts/sc2.tscn"],
		}
	ManagerGame.global_main_ref.emails.push_front(email)
	
	queue_free()
