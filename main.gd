extends Node3D

func _ready():
	$WebView.connect("webview_ready", _on_webview_ready)

func _on_webview_ready():
	$WebView.install_navigation_handler(navigation_handler)
	
	# remove cookie popup
	$WebView.set_cookie("www.shadertoy.com", "/", "scmp", "0", false, "", 3390562032)

	if $WebView.load():	
		var mat = $mesh.get_active_material(0)
		mat.albedo_texture = $WebView.get_texture()

func navigation_handler(url, navigation_type) -> bool:
	print("visiting ", url)
	return true
