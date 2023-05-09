extends Node
class_name RetroHubGenericEmulator

var command : String

var _substitutes := {}

func _init(emulator_raw : Dictionary, game_data : RetroHubGameData):
	_substitutes["rompath"] = game_data.path
	var binpath := find_and_substitute_str(emulator_raw["binpath"], _substitutes)
	if not binpath.is_empty():
		_substitutes["binpath"] = binpath
		command = substitute_str(emulator_raw["command"], _substitutes)
	else:
		print("Could not find binpath for emulator \"%s\"" % emulator_raw["name"])

static func find_and_substitute_str(paths, substitutes: Dictionary) -> String:
	if paths is Array:
		return substitute_str(FileUtils.test_for_valid_path(paths), substitutes)
	return substitute_str(FileUtils.expand_path(paths), substitutes)

static func substitute_str(path, substitutes: Dictionary) -> String:
	return JSONUtils.format_string_with_substitutes(path, substitutes)

func is_valid() -> bool:
	return not command.is_empty()

func launch_game() -> int:
	var regex := RegEx.new()
	if regex.compile("[^\\s\"']+|\"([^\"]*)\"|'([^']*)'"):
		push_error("Failed to compile regex [GenericEmulator]")
		return -1
	var regex_results := regex.search_all(command)
	var command_base : String = regex_results[0].strings[0]
	var command_args := []
	for idx in range(1, regex_results.size()):
		if not regex_results[idx].strings[1].is_empty():
			command_args.append(regex_results[idx].strings[1])
		else:
			command_args.append(regex_results[idx].strings[0])

	return OS.create_process(command_base, command_args)
