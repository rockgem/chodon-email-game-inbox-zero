extends Control


func _ready() -> void:
	$Panel/VBoxContainer/Sanity/ProgressBar.value = ManagerGame.global_main_ref.sanity
	$Panel/VBoxContainer/JS/ProgressBar.value = ManagerGame.global_main_ref.job_security
