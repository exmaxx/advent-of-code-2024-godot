extends Node2D

var DEFAULT_FONT = ThemeDB.fallback_font
var DEFAULT_FONT_SIZE = ThemeDB.fallback_font_size
var WAIT_TIME = 0.1
var SCROLL_TIME = 0.05
var SCROLL_Y = 35.8 / SCROLL_TIME

var arrays: Dictionary
var is_scrolling = false

func _ready():
	var aoc = AOC.new()
	var result = aoc.calculate()
	
	arrays = result[1]
		
	start_wait_timer()


func _process(delta):
	if is_scrolling:
		$Camera2D.position.y += SCROLL_Y * delta


func _draw():
	for i in range(0, arrays.first.size()):
		var y = 40 * i
		
		draw_string(DEFAULT_FONT, Vector2(0, y), str(arrays.first[i]), HORIZONTAL_ALIGNMENT_LEFT, -1, 40)
		draw_string(DEFAULT_FONT, Vector2(200, y), str(arrays.second[i]), HORIZONTAL_ALIGNMENT_LEFT, -1, 40)
		
		var diff = abs(arrays.first[i] - arrays.second[i])
		draw_string(DEFAULT_FONT, Vector2(400, y), '→ ' + str(diff), HORIZONTAL_ALIGNMENT_LEFT, -1, 40, Color.AQUA)


func start_wait_timer():
	is_scrolling = false
	var timeout = get_tree().create_timer(WAIT_TIME).timeout
	timeout.connect(start_scroll_timer)


func start_scroll_timer():
	is_scrolling = true
	
	var timeout = get_tree().create_timer(SCROLL_TIME).timeout
	timeout.connect(start_wait_timer)
