extends Node2D

var DEFAULT_FONT = ThemeDB.fallback_font
#var DEFAULT_FONT_SIZE = ThemeDB.fallback_font_size
var WAIT_TIME = 0.2
var SCROLL_TIME = 0.05
var BASE_SIZE = 40

var arrays: Dictionary
var is_scrolling = false
var target_y: int

func _ready():
	var aoc = AOC.new()
	var result = aoc.calculate()
	
	arrays = result['arrays']
		
	var tween = get_tree().create_tween()
	tween.set_loops().tween_callback(move_camera).set_delay(WAIT_TIME)
	
	
func move_camera():
	var y_lower = $Camera2D.position.y + BASE_SIZE
	var tween = get_tree().create_tween()
	tween.tween_property($Camera2D, "position:y", y_lower, SCROLL_TIME)
	
	
func _process(delta):
	pass


func _draw():
	print('draw')
	for i in range(0, arrays.first.size()):
		var y = BASE_SIZE * i
		
		draw_col_num(arrays.first[i], Vector2(0, y))
		draw_col_num(arrays.second[i], Vector2(200, y))
		
		var diff = abs(arrays.first[i] - arrays.second[i])
		draw_col_str( '→ ' + str(diff), Vector2(400, y), Color.AQUA)
		
		
func draw_col_str(str, vector, color = Color.WHITE):
	draw_string(DEFAULT_FONT, vector, str, HORIZONTAL_ALIGNMENT_LEFT, -1, BASE_SIZE, color)


func draw_col_num(number, vector, color = Color.WHITE):
	draw_col_str(str(number), vector, color)
	
