extends Control

@onready var n_input_tab := %InputTab

@onready var n_kb_reset := %KBReset

@onready var n_cn_reset := %CNReset
@onready var n_cn_start_layout := %CNStartLayout
@onready var n_cn_clear_layout := %CNClearLayout
@onready var n_cn_icon_type := %CNIconType
@onready var n_cn_pre_delay := %CNPreDelay
@onready var n_cn_delay := %CNDelay

@onready var n_vkb_intro_lbl := %IntroLabel
@onready var n_vkb_layout := %VirtualKeyboardLayout
@onready var n_vkb_type := %VirtualKeyboardType
@onready var n_vkb_show_on_controller := %VirtualKeyboardOnController
@onready var n_vkb_show_on_mouse := %VirtualKeyboardOnMouse

@onready var n_controller_layout_popup := %ControllerLayout
@onready var n_key_remap_popup := %KeyboardRemap
@onready var n_ctrl_button_remap_popup := %ControllerButtonRemap
@onready var n_ctrl_axis_remap_popup := %ControllerAxisRemap

func _ready():
	#warning-ignore:return_value_discarded
	RetroHubConfig.config_ready.connect(_on_config_ready)
	#warning-ignore:return_value_discarded
	RetroHubConfig.config_updated.connect(_on_config_updated)
	#warning-ignore:return_value_discarded
	ControllerIcons.input_type_changed.connect(_on_input_type_changed)

	n_cn_icon_type.get_popup().max_size.y = RetroHubUI.max_popupmenu_height + 50

func grab_focus():
	# Keyboard
	if n_input_tab.current_tab == 0:
		n_kb_reset.grab_focus()
	# Controller
	elif n_input_tab.current_tab == 1:
		n_cn_reset.grab_focus()
	elif n_input_tab.current_tab == 2:
		if RetroHubConfig.config.accessibility_screen_reader_enabled:
			n_vkb_intro_lbl.grab_focus()
		else:
			n_vkb_layout.grab_focus()

func _on_config_ready(config_data: ConfigData):
	n_cn_clear_layout.disabled = config_data.custom_input_remap.is_empty()
	match RetroHubConfig.config.input_controller_icon_type:
		"xbox360":
			n_cn_icon_type.selected = 1
		"xboxone":
			n_cn_icon_type.selected = 2
		"xboxseries":
			n_cn_icon_type.selected = 3
		"ps3":
			n_cn_icon_type.selected = 4
		"ps4":
			n_cn_icon_type.selected = 5
		"ps5":
			n_cn_icon_type.selected = 6
		"switch":
			n_cn_icon_type.selected = 7
		"joycon":
			n_cn_icon_type.selected = 8
		"steam":
			n_cn_icon_type.selected = 9
		"steamdeck":
			n_cn_icon_type.selected = 10
		"luna":
			n_cn_icon_type.selected = 11
		"stadia":
			n_cn_icon_type.selected = 12
		"ouya":
			n_cn_icon_type.selected = 13
		"auto", _:
			n_cn_icon_type.selected = 0
	n_cn_pre_delay.set_value_no_signal(config_data.input_controller_echo_pre_delay)
	n_cn_delay.set_value_no_signal(config_data.input_controller_echo_delay)
	match config_data.virtual_keyboard_layout:
		"qwertz":
			n_vkb_layout.selected = 1
		"azerty":
			n_vkb_layout.selected = 2
		"qwerty", _:
			n_vkb_layout.selected = 0
	n_vkb_show_on_controller.set_pressed_no_signal(config_data.virtual_keyboard_show_on_controller)
	n_vkb_show_on_mouse.set_pressed_no_signal(config_data.virtual_keyboard_show_on_mouse)
	match config_data.virtual_keyboard_type:
		"steam":
			n_vkb_type.selected = 1
		"builtin", _:
			n_vkb_type.selected = 0
	n_vkb_layout.disabled = n_vkb_type.selected != 0

func _on_config_updated(key: String, _old_value, new_value):
	match key:
		ConfigData.KEY_CUSTOM_INPUT_REMAP:
			n_cn_clear_layout.disabled = new_value.is_empty()

func _on_input_type_changed(input_type: int):
	n_cn_start_layout.disabled = Input.get_connected_joypads().is_empty()
	if not is_visible_in_tree():
		n_input_tab.current_tab = input_type

func _on_hide():
	RetroHubConfig._save_config()


func _on_StartLayout_pressed():
	n_controller_layout_popup.popup_centered()


func _on_ClearLayout_pressed():
	var splits := RetroHubConfig.config.custom_input_remap.split(",")
	if splits.size() > 1:
		Input.remove_joy_mapping(splits[0])
	RetroHubConfig.config.custom_input_remap = ""
	RetroHubConfig._save_config()
	n_cn_clear_layout.disabled = true


func _on_ControllerLayout_popup_hide():
	n_cn_clear_layout.disabled = RetroHubConfig.config.custom_input_remap == ""


func _on_KB_pressed(input_key):
	n_key_remap_popup.start(input_key)

func _on_KeyboardRemap_key_remapped(key, old_code, new_code):
	# First, find the old keycode and switch it
	var keymap := RetroHubConfig.config.input_key_map
	if old_code in keymap[key]:
		keymap[key].erase(old_code)
	keymap[key].push_back(new_code)
	# Now, find keys with the new code, and replace with old code
	for _key in keymap:
		if key == _key:
			continue
		if new_code in keymap[_key]:
			TTS.speak("This key was already being used for another action, so they were swapped." ,false)
			keymap[_key].erase(new_code)
			keymap[_key].push_back(old_code)
	RetroHubConfig.config.mark_for_saving()
	RetroHubConfig._save_config()

func _on_CN_pressed(input_key):
	var button := get_viewport().gui_get_focus_owner()
	var pos := button.get_global_transform_with_canvas().get_origin() - Vector2(n_ctrl_button_remap_popup.size.x + 10, 0)
	n_ctrl_button_remap_popup.start(input_key, pos)

func _on_ControllerButtonRemap_remap_done(key, old_button, new_button):
	# First, find the old button and switch it
	var map := RetroHubConfig.config.input_controller_map
	if old_button in map[key]:
		map[key].erase(old_button)
	if not new_button in map[key]:
		map[key].push_back(new_button)
	# Now, find keys with the new code, and replace with old code
	for _key in map:
		if key == _key:
			continue
		if new_button in map[_key]:
			TTS.speak("This button was already being used for another action, so they were swapped." ,false)
			map[_key].erase(new_button)
			if not old_button in map[_key]:
				map[_key].push_back(old_button)
	RetroHubConfig.config.mark_for_saving()
	RetroHubConfig._save_config()

func _on_CNAxis_pressed(axis):
	var button := get_viewport().gui_get_focus_owner()
	var pos := button.get_global_transform_with_canvas().origin - Vector2(n_ctrl_button_remap_popup.size.x + 10, 0)
	n_ctrl_axis_remap_popup.start(axis, pos)

func _on_ControllerAxisRemap_remap_done(action, old_axis, new_axis):
	# There's only two movement sticks, they will always switch places
	var is_main : bool = action == "rh_left"
	RetroHubConfig.config.input_controller_main_axis = new_axis if is_main else old_axis
	RetroHubConfig.config.input_controller_secondary_axis = old_axis if is_main else new_axis
	RetroHubConfig._save_config()


func _on_CNIconType_item_selected(index):
	match index:
		1:
			RetroHubConfig.config.input_controller_icon_type = "xbox360"
		2:
			RetroHubConfig.config.input_controller_icon_type = "xboxone"
		3:
			RetroHubConfig.config.input_controller_icon_type = "xboxseries"
		4:
			RetroHubConfig.config.input_controller_icon_type = "ps3"
		5:
			RetroHubConfig.config.input_controller_icon_type = "ps4"
		6:
			RetroHubConfig.config.input_controller_icon_type = "ps5"
		7:
			RetroHubConfig.config.input_controller_icon_type = "switch"
		8:
			RetroHubConfig.config.input_controller_icon_type = "joycon"
		9:
			RetroHubConfig.config.input_controller_icon_type = "steam"
		10:
			RetroHubConfig.config.input_controller_icon_type = "steamdeck"
		11:
			RetroHubConfig.config.input_controller_icon_type = "luna"
		12:
			RetroHubConfig.config.input_controller_icon_type = "stadia"
		13:
			RetroHubConfig.config.input_controller_icon_type = "ouya"
		0, _:
			RetroHubConfig.config.input_controller_icon_type = "auto"
	ControllerIcons.refresh()

func _on_CNPreDelay_value_changed(value):
	RetroHubConfig.config.input_controller_echo_pre_delay = value


func _on_CNDelay_value_changed(value):
	RetroHubConfig.config.input_controller_echo_delay = value


func _on_KBReset_pressed():
	RetroHubConfig.config.input_key_map = ConfigData.default_input_key_map()
	RetroHubConfig._save_config()


func _on_CNReset_pressed():
	RetroHubConfig.config.input_controller_map = ConfigData.default_input_controller_map()
	RetroHubConfig.config.input_controller_main_axis = "left"
	RetroHubConfig.config.input_controller_secondary_axis = "right"
	RetroHubConfig._save_config()


func _on_VirtualKeyboardLayout_item_selected(index):
	match index:
		1:
			RetroHubConfig.config.virtual_keyboard_layout = "qwertz"
		2:
			RetroHubConfig.config.virtual_keyboard_layout = "azerty"
		0, _:
			RetroHubConfig.config.virtual_keyboard_layout = "qwerty"

func _on_VirtualKeyboardOnController_toggled(button_pressed):
	RetroHubConfig.config.virtual_keyboard_show_on_controller = button_pressed


func _on_VirtualKeyboardOnMouse_toggled(button_pressed):
	RetroHubConfig.config.virtual_keyboard_show_on_mouse = button_pressed


func _on_TabContainerHandler_tab_changed(_tab_container, enter_tab):
	if enter_tab:
		self.grab_focus()


func _on_VirtualKeyboardType_item_selected(index):
	match index:
		1:
			RetroHubConfig.config.virtual_keyboard_type = "steam"
		0, _:
			RetroHubConfig.config.virtual_keyboard_type = "builtin"
	n_vkb_layout.disabled = index != 0

func tts_text(focused: Control):
	if focused is ControllerButton:
		return focused.tooltip_text + ". Current " + ("key" if focused.force_type == 1 else "button") \
			+ ": " + focused.get_tts_string()
	elif focused == n_cn_icon_type and n_cn_icon_type.selected == 0:
		var text := "detect automatically. detected as "
		match ControllerIcons.Mapper._get_joypad_type(ControllerSettings.Devices.XBOX360):
			ControllerSettings.Devices.LUNA:
				text += "amazon luna"
			ControllerSettings.Devices.PS3:
				text += "playstation 3"
			ControllerSettings.Devices.PS4:
				text += "playstation 4"
			ControllerSettings.Devices.PS5:
				text += "playstation 5"
			ControllerSettings.Devices.STADIA:
				text += "google stadia"
			ControllerSettings.Devices.STEAM:
				text += "steam controller"
			ControllerSettings.Devices.SWITCH:
				text += "nintendo switch pro controller"
			ControllerSettings.Devices.JOYCON:
				text += "nintendo switch joy con"
			ControllerSettings.Devices.XBOX360:
				text += "xbox 360"
			ControllerSettings.Devices.XBOXONE:
				text += "xbox one"
			ControllerSettings.Devices.XBOXSERIES:
				text += "xbox series"
			ControllerSettings.Devices.STEAM_DECK:
				text += "steam deck"
			ControllerSettings.Devices.OUYA:
				text += "ouya"
		return text
	return ""
