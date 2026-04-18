extends Sprite2D
class_name HeartPopUp

@export var _visible : bool = true;
@export var popup_speed : float = 10;
@export var health : int = 100;
var mover : SmoothMovement
var label : Label;
var timer : Timer;
var position_offset : Vector2

static func init(sprite:Texture2D, parent:Node2D, _position:Vector2) -> HeartPopUp:
	var popup = HeartPopUp.new();
	parent.add_child(popup)
	popup.global_position = _position + parent.global_position;
	popup.texture = sprite;
	return popup

func _ready() -> void:
	mover = SmoothMovement.init(self);
	mover.speed = popup_speed;
	mover.movement = false;
	mover.rotation_on = false;
	label = Label.new();
	add_child(label);

func _process(delta: float) -> void:
	global_position = position_offset + get_parent().global_position;
	global_rotation = get_parent().rotation;
	label.text = str(health);
	if _visible == true:
		mover.global_target_scale = Vector2(1,1);
	else:
		mover.global_target_scale = Vector2(0,0);

func popup(time: float) -> void:
	_visible = true;
	timer = Timer.new();
	timer.wait_time = time;
	timer.one_shot = true;
	timer.connect("timeout", _on_timer_timeout)

func _on_timer_timeout() -> void:
	_visible = false;
