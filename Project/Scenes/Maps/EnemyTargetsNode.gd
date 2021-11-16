extends Node2D
class_name EnemyTargetsNode

signal player_damaged(damage)

var target_areas: Dictionary = {}

#func _init() -> void:
#	pass

func _ready() -> void:
	var index = 0
	for child in get_children():
		if(child is EnemyTargetArea):
			child.connect("player_damaged", self, "_on_player_damaged")
			target_areas[index] = child
			index += 1

func get_target_areas() -> Dictionary:
	return target_areas
	
func get_target_area(_target_index: int) -> EnemyTargetArea:
	return target_areas.get(_target_index)

func _on_player_damaged(damage: float) -> void:
	emit_signal("player_damaged", damage)