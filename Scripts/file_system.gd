extends Node

var files = File.new()
var dirs = Directory.new()

func save_data(file_name, data):
	files.open('user://'+file_name, File.WRITE)
	files.store_string(to_json(data))
	files.close()
	#print('Записано', to_json(data), 'в', 'file_name')

func load_data(file_name):
	files.open('user://'+file_name, File.READ)
	var content = files.get_as_text()
	files.close()
	if content:
		return parse_json(content)
	else:
		return null
