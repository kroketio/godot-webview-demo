extends Node3D

func _ready():
	$QuickView.connect("quickview_ready", _on_quickview_ready)

func _on_quickview_ready():
	if $QuickView.load():
		$viewhelper.set_texture($QuickView.get_texture())
