extends Control


var day = 1
var emails = []

var job_security = 100.0
var sanity = 100.0

func _ready() -> void:
	ManagerGame.pop_to_ui.connect(on_pop_to_ui)
	ManagerGame.email_viewed.connect(on_email_viewed)
	ManagerGame.email_deleted.connect(on_email_deleted)
	
	ManagerGame.global_main_ref = self
	
	load_day_emails()


func _physics_process(delta: float) -> void:
	$Stats/VBoxContainer/Sanity/ProgressBar.value = sanity
	$Stats/VBoxContainer/JS/ProgressBar.value = job_security


func refresh_emails_display():
	for child in $InboxPanel/Panel/ScrollContainer/List.get_children():
		child.queue_free()
	
	for email in emails:
		var i = load('res://actors/ui/PreviewBox.tscn').instantiate()
		i.data = email
		i.get_node('SenderName').text = email['sender_name']
		i.get_node('Body').text = email['body']
		
		$InboxPanel/Panel/ScrollContainer/List.add_child(i)


func load_day_emails():
	var e = ManagerGame.emails_data['day_%s' % day]
	e.reverse()
	
	for email in e:
		emails.push_front(email)
	
	refresh_emails_display()
	
	on_email_viewed(null)


func on_pop_to_ui(instance):
	
	$Popup.add_child(instance)


func on_email_viewed(data):
	var new_emails = 0
	for e in emails:
		if e.has('is_viewed') == false:
			new_emails += 1
	
	$InboxPanel/HBoxContainer/Inbox.text = 'Inbox (%s)' % new_emails


func on_email_deleted(data):
	var deleted = 0
	for e in emails:
		if e.has('status'):
			if e['status'] == 'deleted':
				deleted += 1
	
	$InboxPanel/HBoxContainer/Deleted.text = 'Deleted (%s)' % deleted


func _on_next_day_pressed() -> void:
	day += 1
	
	load_day_emails()
	
	ManagerGame.next_day_activated.emit()
