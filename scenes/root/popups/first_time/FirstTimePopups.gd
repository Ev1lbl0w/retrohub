extends Popup

onready var n_sidebar = $Panel/HBoxContainer/VBoxGuide
onready var n_content = $Panel/HBoxContainer/PanelContainer

onready var n_main_content = $"%MainContent"

onready var num_sections = n_sidebar.get_child_count()

func reset_section():
	n_main_content.current_tab = 0
	_on_MainContent_tab_changed(0)

func advance_section():
	if n_main_content.current_tab == n_main_content.get_tab_count() - 1:
		hide()
		RetroHubConfig.config.is_first_time = false
		RetroHubConfig.save_config()
	n_main_content.current_tab += 1


func _on_FirstTimePopup_about_to_show():
	reset_section()


func _on_MainContent_tab_changed(tab):
	n_main_content.get_tab_control(tab).grab_focus()
	
	var counter = 0
	for child in n_sidebar.get_children():
		if counter == tab:
			child.modulate = Color(1,1,1,1)
		elif counter < tab:
			child.modulate = Color("8ffcff")
		else:
			child.modulate = Color(1,1,1,0.4)
		counter += 1


func _on_FirstTimePopup_popup_hide():
	get_parent().remove_child(self)
	queue_free()
