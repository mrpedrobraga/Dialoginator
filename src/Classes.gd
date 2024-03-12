class_name Classes

class ActionsSpec extends Resource:
	var groups: Dictionary # [String -> ActionSpecGroup]
	
	func dict() -> Dictionary:
		return { "groups": Utils.map_dict(groups) }

class ActionSpecGroup extends Resource:
	var name: String
	var actions: Dictionary # [String -> ActionSpec]
	
	func dict() -> Dictionary:
		return { "name": name, "actions": Utils.map_dict(actions) }

class ActionSpec extends Resource:
	var code: String
	var name: String
	var description: String
	var params: Dictionary # [String -> ParamSpec]
	
	func dict() -> Dictionary:
		return { "code": code, "name": name, "description": description, "params": Utils.map_dict(params) }

class ParamSpec extends Resource:
	var name: String
	var description: String
	var type: String
	
	func dict() -> Dictionary:
		return { "name": name, "description": description, "type": type }

static func get_action_spec_from_file(path: String) -> ActionSpec:
	var f = File.new()
	f.open("res://test/test.json", File.READ)
	var raw = f.get_as_text()
	var dict = JSON.parse(raw)
	return parse_action_spec(dict.result)

static func parse_action_spec(dict: Dictionary):
	var ac = ActionsSpec.new()
	ac.groups = parse_groups(dict)
	return ac

static func parse_groups(dict: Dictionary) -> Array:
	var groups = {}
	
	for k in dict.keys():
		var group = ActionSpecGroup.new()
		group.name = k
		group.actions = parse_actions(dict[k])
		groups[k] = group
	
	return groups

static func parse_actions(dict: Dictionary) -> Dictionary:
	var actions = {}
	
	for k in dict.keys():
		var action = ActionSpec.new()
		action.code = k
		action.name = dict[k].get("name", "Unknown Action")
		action.description = dict[k].get("description", "")
		action.params = parse_params(dict[k])
		actions[k] = action
	
	return actions

static func parse_params(dict: Dictionary) -> Dictionary:
	var params = {}
	
	for k in dict.keys():
		var param = ParamSpec.new()
		param.name = k
		param.type = dict[k].get("type", "unknown")
	
	return params
