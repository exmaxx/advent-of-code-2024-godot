extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#var content = load_from_file('res://01/01-example.txt')
	var content = load_from_file('res://01/01-input.txt')
	
	var lines = split_content(content)
	var arrays = parse_lines(lines)	
	var sum: int = calc_sum(arrays['first'], arrays['second'])
	
	print(sum)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func load_from_file(path: String) -> String:
	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	
	return content


func split_content(content: String) -> PackedStringArray:
	var lines = content.split('\n', false)
	
	return lines


func parse_lines(lines: PackedStringArray) -> Dictionary:
	var first: PackedInt32Array
	var second: PackedInt32Array
	
	for line in lines:
		var split = parse_line(line)
		
		first.append(split[0])
		second.append(split[1])
		
	return {"first": first, "second": second}
	
	
func parse_line(line: String) -> PackedFloat32Array:
	var split = line.split(" ", false)
	
	return [int(split[0]), int(split[1])]


func calc_sum(first: PackedInt32Array, second: PackedInt32Array) -> int:
	var sum = 0
	
	first.sort()
	second.sort()

	for i in range(0, first.size()):
		sum += absi(first[i] - second[i])	
	
	return sum
