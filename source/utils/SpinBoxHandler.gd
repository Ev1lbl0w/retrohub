extends Control
class_name SpinBoxHandler

## Hack for tackling focus issues with spinboxes
## Must be added as a child component of a spin box, aka
## get_parent() returns the spin box

enum Dir {
	TOP,
	BOTTOM,
	LEFT,
	RIGHT,
	NEXT,
	PREVIOUS
}

func _ready():
	# This _ready is called before parent, we need to wait a frame for parent to initialize
	mouse_filter = MOUSE_FILTER_IGNORE
	await get_tree().process_frame
	var spin_box : SpinBox = get_parent()
	if not spin_box:
		return
	spin_box.focus_mode = FOCUS_ALL
	#warning-ignore:return_value_discarded
	spin_box.focus_entered.connect(_on_focus_entered)
	for dir in [
		Dir.TOP,
		Dir.BOTTOM,
		Dir.LEFT,
		Dir.RIGHT,
		Dir.NEXT,
		Dir.PREVIOUS
	]:
		handle_neighbors(dir)


func handle_neighbors(dir: int):
	var neighbor : NodePath
	match dir:
		Dir.TOP:
			neighbor = get_parent().focus_neighbor_top
		Dir.BOTTOM:
			neighbor = get_parent().focus_neighbor_bottom
		Dir.LEFT:
			neighbor = get_parent().focus_neighbor_left
		Dir.RIGHT:
			neighbor = get_parent().focus_neighbor_right
		Dir.NEXT:
			neighbor = get_parent().focus_next
		Dir.PREVIOUS:
			neighbor = get_parent().focus_previous

	if neighbor == null or neighbor.is_empty():
		return

	var neighbor_obj := get_node(NodePath("../" + neighbor.get_concatenated_names()))

	var raw_path := ".."
	for i in range(neighbor.get_name_count()):
		raw_path += "/" + neighbor.get_name(i)
	if neighbor_obj is SpinBox:
		raw_path += "/" + neighbor_obj.get_line_edit().get_name()

	match dir:
		Dir.TOP:
			get_parent().get_line_edit().focus_neighbor_top = NodePath(raw_path)
		Dir.BOTTOM:
			get_parent().get_line_edit().focus_neighbor_bottom = NodePath(raw_path)
		Dir.LEFT:
			get_parent().get_line_edit().focus_neighbor_left = NodePath(raw_path)
		Dir.RIGHT:
			get_parent().get_line_edit().focus_neighbor_right = NodePath(raw_path)
		Dir.NEXT:
			get_parent().get_line_edit().focus_next = NodePath(raw_path)
		Dir.PREVIOUS:
			get_parent().get_line_edit().focus_previous = NodePath(raw_path)

func _on_focus_entered():
	get_parent().get_line_edit().grab_focus()
