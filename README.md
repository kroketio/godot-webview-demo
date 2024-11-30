## godot-webview demo

1. Download this repository
2. Extract the [godot-webview addon](https://godotwebview.com/pages/downloads/) into the root of the project.
3. Open the project in Godot 4.4
4. Run the project, use WASD to move around, right mouse click to look

## Information

This demo has 3 scenes, in `scenes/`.

1. A 3D plane with a webview applied to it
2. A 2D example of a TextureRect filling the whole screen, has mouse and keyboard support
3. mouse input example scene, handy for debugging mouse events

Switching between them can be done over at `Project -> Project Settings -> Application -> Run`.

## Mac OS: Metal

important: this project is configured to use Vulkan. On Mac OS, only the 
Metal renderer is available. Switch to the Metal renderer 
`Project -> Project Settings`.

![](metal.png)

## Keyboard events

#### Method 1

Enable "Capture keys" in the WebView properties.

#### Method 2

Do it programmatically:

```
$WebView.capture_keys = true
```

Which will automatically scan/submit keys.

#### Method 3

Do it manually, by using `$WebView.key_event(keycode, event_Type, text)`:

```
func handle_key_event(event):
    var key_help = ""

    if event.unicode != 0:
        key_help = OS.get_keycode_string(event.unicode)

    var keycode = DisplayServer.keyboard_get_keycode_from_physical(event.physical_keycode)
    var key: int = event.get_keycode_with_modifiers()
    var key_phys: int = event.get_physical_keycode_with_modifiers()
    var keycode_str = OS.get_keycode_string(key)

    var is_pressed: bool = event.is_pressed()
    var is_key_sequence: bool = "+" in keycode_str
    var event_type: int = 0 if is_pressed else 1

    if is_key_sequence and not key_help.is_empty():
        key_help = keycode_str

    return {
        "keycode": keycode,
        "event_type": event_type,
        "key_help": key_help
    }

func _input(event):
    if event is InputEventKey:
        res = handle_key_event(event)
        $WebView.key_event(res['keycode'], res['event_type'], res['text'])
```

## Documentation

For more information, checkout the [website](https://github.com/kroketio/godot-webview-demo)

For help or feedback, reach out via:
- [Discord](https://discord.gg/jjuyfgbE7m)
- [Github issue tracker](https://github.com/kroketio/godot-webview-meta/issues)
