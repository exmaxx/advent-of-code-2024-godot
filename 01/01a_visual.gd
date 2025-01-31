extends Node2D

var DEFAULT_FONT = ThemeDB.fallback_font
#var DEFAULT_FONT_SIZE = ThemeDB.fallback_font_size
var WAIT_TIME = 0.2
var SCROLL_TIME = 0.05
var BASE_SIZE = 40
var ROW_OFFSET = 18
var SUM_OFFSET = 4
var BASE_OFFSET = ROW_OFFSET * BASE_SIZE
var INDEX_OFFSET = ROW_OFFSET - SUM_OFFSET - 2

var arrays: Dictionary
var is_scrolling = false
var target_y: int

var loop = 0
var subtotal = 0


func _ready():
	var aoc = AOC.new()
	var result = aoc.calculate()
	
	arrays = result['arrays']
	
	$CanvasLayer/Sum.position = Vector2(400, SUM_OFFSET * BASE_SIZE)
		
	var tween = get_tree().create_tween()
	tween.set_loops().tween_callback(update).set_delay(WAIT_TIME)
	

func update():
	var is_sum_row_reached = loop >= INDEX_OFFSET
	
	if (is_sum_row_reached):
		animate_sum(loop - INDEX_OFFSET)
		animate_and_remove_row(loop - INDEX_OFFSET)
		
	move_camera()
	
	loop += 1
	
	
func move_camera():
	var y_lower = $Camera2D.position.y + BASE_SIZE
	var tween = get_tree().create_tween()
	tween.tween_property($Camera2D, "position:y", y_lower, SCROLL_TIME)

	
func _process(delta):
	pass


func _draw():
	print('draw')
	for i in range(0, arrays.first.size()):
		var y = BASE_SIZE * i + BASE_OFFSET
		
		add_numbers(i)
		add_diff(i)

func draw_col_str(str: String, vector: Vector2, color: Color = Color.WHITE):
	draw_string(DEFAULT_FONT, vector, str, HORIZONTAL_ALIGNMENT_LEFT, -1, BASE_SIZE, color)


func draw_col_num(number: int, vector: Vector2, color = Color.WHITE):
	draw_col_str(str(number), vector, color)
	
	
func animate_sum(index):
	print(index)
	var diff = abs(arrays.first[index] - arrays.second[index])
	print(diff)
	
	subtotal += diff
	
	$CanvasLayer/Sum.text = str(subtotal)
	pass
	
	
func animate_and_remove_row(row):
	var node = get_node('diff#' + str(row))

	var tween = node.create_tween()
	tween.tween_property(node, "modulate:a", 0, SCROLL_TIME * 4)
	tween.tween_property(node, "scale", 0, SCROLL_TIME * 4)
	
	tween.tween_callback(node.queue_free)
	

func add_numbers(row: int):
	var name = 'numbers#' + str(row)

	var text = str(arrays.first[row]) + '    ' + str(arrays.second[row])
	
	var y = BASE_SIZE * row + BASE_OFFSET
	var pos = Vector2(0, y)
	
	add_label(text, pos, Color.WHITE, name)


func add_diff(row: int):
	var name = 'diff#' + str(row)
	
	var diff = abs(arrays.first[row] - arrays.second[row])
	var text = str(diff)
	
	var y = BASE_SIZE * row + BASE_OFFSET
	var pos = Vector2(400, y)
	
	add_label(text, pos, Color.AQUAMARINE, name)


func add_label(text, pos, color = Color.WHITE, name = null):
	var label = Label.new()
	
	label.add_theme_color_override('font_color', color)
	label.add_theme_font_size_override('font_size', BASE_SIZE)
	
	if name:
		label.name = name
	
	label.text = text
	
	label.position = pos
	
	add_child(label)
