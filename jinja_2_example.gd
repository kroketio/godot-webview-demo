extends Node3D

@onready var JINJA_ENV: Jinja2Environment = Jinja2Environment.new()

func _ready() -> void:
	$WebView.connect("view_ready", _on_view_ready)
	JINJA_ENV.set_base_directory("res://web/jinja2/")

func _on_view_ready():
	if $WebView.load():
		var tmpl: Jinja2Template = JINJA_ENV.get_template("hello.jinja2")

		var params: Dictionary = {
			"title": "Hello World",
			"foo": true,
			"bar": {
				"items": ["hi!", 2]
			},
			"vec": Vector2(2.5, 4.3),
			"num": 5.5
		}

		var html: String = tmpl.render(params)
		$WebView.load_html(html, "res://godot/web/jinja2/index.html")
