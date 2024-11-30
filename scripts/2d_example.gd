extends Node2D

@onready var window = get_window()
@onready var webview = $WebView
@onready var output = $output

var WEBVIEW_LOADED: bool = false

func _ready() -> void:
	# make TextureRect fill the screen
	output.size = window.size
	
	# deal with window resolution changes
	get_tree().get_root().size_changed.connect(_on_window_resize)
	
	# setup webview
	webview.connect("webview_ready", _on_webview_ready)

func _on_window_resize():
	output.size = window.size

func _on_webview_ready():
	# load webview
	if webview.load():
		output.texture = webview.get_texture()
		WEBVIEW_LOADED = true

# handle mouse x,y and click events
func _input(event):
	if not WEBVIEW_LOADED:
		return

	if event is InputEventMouse:
		var point = event.position
		# calc pos relative to window size, as webview size may be different
		var pct_x: float = 100 * float(point.x)/float(window.size.x)
		var pct_y: float = 100 * float(point.y)/float(window.size.y)

		var target_x: float = (pct_x * webview.resolution.x) / 100.0
		var target_y: float = (pct_y * webview.resolution.y) / 100.0

		if event.is_pressed() and Input.is_action_pressed("lmb"):
			webview.mouse_click(0, 0, target_x, target_y)
		elif event.is_released() and Input.is_action_just_released("lmb"):
			webview.mouse_click(0, 1, target_x, target_y)
		else:
			webview.mouse_move(target_x, target_y)
			
			# if you have a custom mouse pointer, you can update it here
			#pointer.position.x = point.x
			#pointer.position.y = point.y
