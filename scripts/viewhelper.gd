extends MeshInstance3D

# a helper class to detect the mouse in 3D space

@export  var quickview: QuickView
@onready var area3d = get_node("Area3D")
@onready var collision = get_node("Area3D/CollisionShape3D")

func set_texture(tex: Texture2DRD):
	var mat = $".".get_active_material(0)
	mat.albedo_color = Color("#FFFFFF")
	mat.albedo_texture = tex

func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	var point = calculate_mouse_position(event_position)

	if event.is_pressed() and Input.is_action_pressed("lmb"):
		quickview.mouse_click(0, 0, point.x, point.y)
	elif event.is_released() and Input.is_action_just_released("lmb"):
		quickview.mouse_click(0, 1, point.x, point.y)
	else:
		quickview.mouse_move(point.x, point.y)

# warning: this function is probably silly. If you know a 
# better way to detect the mouse position on a 3D object, 
# feel free to replace it.
func calculate_mouse_position(event_position: Vector3) -> Vector2:
	var local_pos = area3d.to_local(event_position)

	var obj_size = Vector2(collision.shape.size.x, 
		collision.shape.size.z)

	var rel_pos = Vector2(local_pos.x + obj_size.x / 2, 
		(local_pos.z - obj_size.y / 2) + obj_size.y) 

	var pct = Vector2((100 * rel_pos.x/obj_size.x),
		(100 * rel_pos.y/obj_size.y))

	var _x = (pct.x * quickview.resolution.x) / 100.0
	var _y = (pct.y * quickview.resolution.y) / 100.0
	return Vector2(_x,_y)
