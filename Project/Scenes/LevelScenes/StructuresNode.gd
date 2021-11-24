extends Node2D
class_name StructuresNode

func get_class() -> String:
	return "StructuresNode"

signal structure_destroyed(structure_type, enemy_position)

var structures_dict: Dictionary = {}

var debug: bool = false

func _ready() -> void:
	ControllersRef.set_controller_reference("structures_node", self)
	for child in get_children():
		if(child is Structure):
			add_structure(child)

# adds structure instance to the node, and to the dictionary
func add_structure(_structure: Node2D) -> bool:
	if(_structure == null):
		return false
	if(structures_dict.has(_structure.get_instance_id())):
		return false
	structures_dict[_structure.get_instance_id()] = _structure
	_structure.set_debug(debug)
	_structure.connect("structure_destroyed", self, "_on_structure_destroyed")
	_structure.connect("tree_exiting", self, "_on_structure_exiting", [_structure.get_instance_id()])
	add_child(_structure)
	return true
	
func get_structure(_instance_id: int):
	return structures_dict.get(_instance_id)

func get_structures_dict() -> Dictionary:
	return structures_dict

func get_all_structures() -> Array:
	return structures_dict.values()
	
func _on_structure_exiting(_instance_id: int) -> void:
	if(structures_dict.has(_instance_id)):
		structures_dict.erase(_instance_id)

func _on_structure_destroyed(structure_type: String, structure_pos: Vector2):
	emit_signal("structure_destroyed", structure_type, structure_pos)
