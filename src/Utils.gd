class_name Utils

static func map_dict(input: Dictionary):
	var result = {}
	for k in input.keys():
		result[k] = input[k].dict()
	return result
