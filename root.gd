extends Node3D

func _ready() -> void:
	$WebView.connect("view_ready", _on_view_ready)

func _on_view_ready():
	$WebView.load()
