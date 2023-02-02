extends Resource
class_name ConfigData

signal config_updated(key, old_value, new_value)

var _config_changed := false
var _old_config : Dictionary

# Games directory
var is_first_time : bool = true setget _set_is_first_time
var games_dir : String = FileUtils.get_home_dir() + "/ROMS" setget _set_games_dir
var current_theme : String = "default" setget _set_current_theme
var lang : String = "en" setget _set_lang
var fullscreen : bool = true setget _set_fullscreen
var vsync : bool = true setget _set_vsync
var render_resolution : int = 100 setget _set_render_resolution
var region : String = "usa" setget _set_region
var rating_system : String = "esrb" setget _set_rating_system
var date_format : String = "mm/dd/yyyy" setget _set_date_format
var scraper_ss_use_custom_account : bool = false setget _set_scraper_ss_use_custom_account
var scraper_ss_username : String = "" setget _set_scraper_ss_username
var scraper_ss_password : String = "" setget _set_scraper_ss_password
var custom_input_remap : String = "" setget _set_custom_input_remap
var input_key_map : Dictionary = default_input_key_map() setget _set_input_key_map
var input_controller_map : Dictionary = default_input_controller_map() setget _set_input_controller_map
var input_controller_main_axis : int = JOY_ANALOG_LX setget _set_input_controller_main_axis
var input_controller_secondary_axis : int = JOY_ANALOG_RX setget _set_input_controller_secondary_axis
var input_controller_icon_type : int = -1 setget _set_input_controller_icon_type

const KEY_IS_FIRST_TIME = "is_first_time"
const KEY_GAMES_DIR = "games_dir"
const KEY_CURRENT_THEME = "current_theme"
const KEY_LANG = "lang"
const KEY_FULLSCREEN = "fullscreen"
const KEY_VSYNC = "vsync"
const KEY_RENDER_RESOLUTION = "render_resolution"
const KEY_REGION = "region"
const KEY_RATING_SYSTEM = "rating_system"
const KEY_DATE_FORMAT = "date_format"
const KEY_SCRAPER_SS_USE_CUSTOM_ACCOUNT = "scraper_ss_use_custom_account"
const KEY_SCRAPER_SS_USERNAME = "scraper_ss_username"
const KEY_SCRAPER_SS_PASSWORD = "scraper_ss_password"
const KEY_CUSTOM_INPUT_REMAP = "custom_input_remap"
const KEY_INPUT_KEY_MAP = "input_key_map"
const KEY_INPUT_CONTROLLER_MAP = "input_controller_map"
const KEY_INPUT_CONTROLLER_MAIN_AXIS = "input_controller_main_axis"
const KEY_INPUT_CONTROLLER_SECONDARY_AXIS = "input_controller_secondary_axis"
const KEY_INPUT_CONTROLLER_ICON_TYPE = "input_controller_icon_type"

const _keys = [
	KEY_IS_FIRST_TIME,
	KEY_GAMES_DIR,
	KEY_CURRENT_THEME,
	KEY_LANG,
	KEY_FULLSCREEN,
	KEY_VSYNC,
	KEY_RENDER_RESOLUTION,
	KEY_REGION,
	KEY_RATING_SYSTEM,
	KEY_DATE_FORMAT,
	KEY_SCRAPER_SS_USE_CUSTOM_ACCOUNT,
	KEY_SCRAPER_SS_USERNAME,
	KEY_SCRAPER_SS_PASSWORD,
	KEY_CUSTOM_INPUT_REMAP,
	KEY_INPUT_KEY_MAP,
	KEY_INPUT_CONTROLLER_MAP,
	KEY_INPUT_CONTROLLER_MAIN_AXIS,
	KEY_INPUT_CONTROLLER_SECONDARY_AXIS,
	KEY_INPUT_CONTROLLER_ICON_TYPE
]

var _should_save : bool = true

static func default_input_key_map() -> Dictionary:
	return {
		"rh_accept": [KEY_ENTER],
		"rh_back": [KEY_BACKSPACE],
		"rh_major_option": [KEY_CONTROL],
		"rh_minor_option": [KEY_ALT],
		"rh_menu": [KEY_ESCAPE],
		"rh_theme_menu": [KEY_SHIFT],
		"rh_up": [KEY_UP, KEY_W],
		"rh_down": [KEY_DOWN, KEY_S],
		"rh_left": [KEY_LEFT, KEY_A],
		"rh_right": [KEY_RIGHT, KEY_D],
		"rh_left_shoulder": [KEY_Q],
		"rh_right_shoulder": [KEY_E]
	}

static func default_input_controller_map() -> Dictionary:
	return {
		"rh_accept": [JOY_XBOX_A],
		"rh_back": [JOY_XBOX_B],
		"rh_major_option": [JOY_XBOX_X],
		"rh_minor_option": [JOY_XBOX_Y],
		"rh_menu": [JOY_START],
		"rh_theme_menu": [JOY_SELECT],
		"rh_up": [JOY_DPAD_UP],
		"rh_down": [JOY_DPAD_DOWN],
		"rh_left": [JOY_DPAD_LEFT],
		"rh_right": [JOY_DPAD_RIGHT],
		"rh_left_shoulder": [JOY_L],
		"rh_right_shoulder": [JOY_R],
		"rh_left_trigger": [JOY_L2],
		"rh_right_trigger": [JOY_R2]
	}

func _set_is_first_time(_is_first_time):
	mark_for_saving()
	is_first_time = _is_first_time

func _set_games_dir(_games_dir):
	mark_for_saving()
	games_dir = _games_dir

func _set_current_theme(_current_theme):
	mark_for_saving()
	if "res://default_themes" in _current_theme:
		current_theme = _current_theme.get_file().get_basename()
	else:
		current_theme = _current_theme

func _set_lang(_lang):
	mark_for_saving()
	lang = _lang

func _set_fullscreen(_fullscreen):
	mark_for_saving()
	fullscreen = _fullscreen

func _set_vsync(_vsync):
	mark_for_saving()
	vsync = _vsync

func _set_render_resolution(_render_resolution):
	mark_for_saving()
	render_resolution = _render_resolution

func _set_region(_region):
	mark_for_saving()
	region = _region

func _set_rating_system(_rating_system):
	mark_for_saving()
	rating_system = _rating_system

func _set_date_format(_date_format):
	mark_for_saving()
	date_format = _date_format

func _set_scraper_ss_use_custom_account(_scraper_ss_use_custom_account):
	mark_for_saving()
	scraper_ss_use_custom_account = _scraper_ss_use_custom_account

func _set_scraper_ss_username(_scraper_ss_username):
	mark_for_saving()
	scraper_ss_username = _scraper_ss_username

func _set_scraper_ss_password(_scraper_ss_password):
	mark_for_saving()
	scraper_ss_password = _scraper_ss_password

func _set_custom_input_remap(_custom_input_remap):
	mark_for_saving()
	custom_input_remap = _custom_input_remap

func _set_input_key_map(_input_key_map):
	mark_for_saving()
	input_key_map = _input_key_map.duplicate(true)

	# Change all values to int
	for key in input_key_map:
		var arr_int := []
		for val in input_key_map[key]:
			arr_int.push_back(int(val))
		input_key_map[key] = arr_int

func _set_input_controller_map(_input_controller_map):
	mark_for_saving()
	input_controller_map = _input_controller_map.duplicate(true)

	# Change all values to int
	for key in input_controller_map:
		var arr_int := []
		for val in input_controller_map[key]:
			arr_int.push_back(int(val))
		input_controller_map[key] = arr_int

func _set_input_controller_main_axis(_input_controller_main_axis):
	mark_for_saving()
	input_controller_main_axis = _input_controller_main_axis

func _set_input_controller_secondary_axis(_input_controller_secondary_axis):
	mark_for_saving()
	input_controller_secondary_axis = _input_controller_secondary_axis

func _set_input_controller_icon_type(_input_controller_icon_type):
	mark_for_saving()
	input_controller_icon_type = _input_controller_icon_type

func mark_for_saving():
	if _should_save:
		_config_changed = true

func load_config_from_path(path: String) -> int:
	# Open file
	var file = File.new()
	var err = file.open(path, File.READ)
	if err:
		print("Error opening config file " + path + " for reading!")
		return err

	# Parse file
	var json_result = JSON.parse(file.get_as_text())
	if(json_result.error):
		print("Error parsing config file!")
		return ERR_FILE_CORRUPT

	# Dictionary ready for retrieval
	_old_config = json_result.result

	_should_save = false
	for key in _keys:
		if _old_config.has(key):
			set(key, _old_config[key])
		else:
			_config_changed = true
	_should_save = true

	return OK

func save_config_to_path(path: String, force_save: bool = false) -> int:
	if not _config_changed and not force_save:
		return OK

	# Open file
	var file := File.new()
	if(file.open(path, File.WRITE)):
		print("Error opening config file " + path + "for saving!")
		return ERR_CANT_OPEN

	# Construct dict and save config
	var dict = {}
	for key in _keys:
		dict[key] = get(key)

	# Save JSON to file
	var json_output = JSON.print(dict, "\t")
	file.store_string(json_output)
	file.close()
	_config_changed = false

	# Now signal any changes that ocurred to the config file
	for key in _keys:
		if _old_config.has(key):
			if _old_config[key] is Dictionary:
				if _old_config[key].values().hash() != get(key).values().hash():
					emit_signal("config_updated", key, _old_config[key], get(key))
			elif _old_config[key] != get(key):
				emit_signal("config_updated", key, _old_config[key], get(key))
		else:
			emit_signal("config_updated", key, null, get(key))

	_old_config = dict.duplicate(true)
	return OK
