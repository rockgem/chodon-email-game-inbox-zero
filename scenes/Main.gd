extends Control


var day = 1
var emails = []

var job_security = 100.0
var sanity = 100.0

func _ready() -> void:
	ManagerGame.pop_to_ui.connect(on_pop_to_ui)
	
	load_day_emails()


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
	emails = ManagerGame.emails_data['day_%s' % day]
	
	refresh_emails_display()


func on_pop_to_ui(instance):
	
	$Popup.add_child(instance)
