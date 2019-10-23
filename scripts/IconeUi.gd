extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_focus_enter():
	set_self_modulate( Color(0,0,0,1))

func _on_focus_exit():
	set_self_modulate( Color(0.5,0.5,0.5,1))