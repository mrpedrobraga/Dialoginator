extends Panel

func _ready():
	var result = Classes.get_action_spec_from_file("res://test/test.json")
	
	print(
		JSON.print(result.dict(), "\t")
	)
