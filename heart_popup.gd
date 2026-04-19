extends Sprite2D
class_name HeartPopUp

@export var _visible : bool = true;
@export var popup_speed : float = 10;
@export var health : int = 100;
@export var text_size : float = 0.8;
var mover : SmoothMovement
var label : Label;
var timer : Timer;
var position_offset : Vector2

static func init(sprite:Texture2D, parent:Node2D, _position:Vector2) -> HeartPopUp:
	var popup = HeartPopUp.new();
	parent.add_child(popup)
	popup.position_offset = _position;
	popup.global_position = _position + parent.global_position;
	popup.texture = sprite;
	return popup

func _ready() -> void:
	mover = SmoothMovement.init(self);
	mover.speed = popup_speed;
	mover.movement = false;
	mover.rotation_on = false;
	label = Label.new();
	label.autowrap_mode = TextServer.AUTOWRAP_OFF
	label.clip_text = false
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER;
	add_child(label);

func _process(delta: float) -> void:
	_set_label_size(text_size,text_size)
	_set_label_position()
	label.z_index = z_index + 1;
	rotation = 0;
	label.text = str(health);
	if _visible == true:
		mover.global_target_scale = Vector2(1,1);
	else:
		mover.global_target_scale = Vector2(0,0);

func _set_label_position() -> void:
	var text_width = LabelHelper.get_text_width(label)
	var text_height = LabelHelper.get_text_height(label)
	
	# Apply the label's scale to the text dimensions
	var scaled_width = text_width * label.scale.x
	var scaled_height = text_height * label.scale.y
	
	# Position centered with scaled dimensions
	label.position = Vector2(0 - scaled_width/2, 0 - scaled_height/2)

func _set_label_size(width_percent: float = 1.0, height_percent: float = 1.0) -> void:
	if texture:
		var sprite_width = SpriteHelper.get_width(self)
		var sprite_height = SpriteHelper.get_height(self)
		
		# Calculate target size based on percentages
		var target_width = sprite_width * width_percent
		var target_height = sprite_height * height_percent
		
		# Get the label's natural size (with current font)
		var label_natural_size = LabelHelper.get_text_size(label)
		
		# Calculate how much to scale the label to fit
		var scale_x = target_width / label_natural_size.x if label_natural_size.x > 0 else 1.0
		var scale_y = target_height / label_natural_size.y if label_natural_size.y > 0 else 1.0
		
		# Use uniform scaling (keep text proportions)
		var uniform_scale = min(scale_x, scale_y)
		
		# Apply scale to label
		label.scale = Vector2(uniform_scale, uniform_scale)
		
		# Optional: Add minimum scale
		label.scale = Vector2(max(0.1, uniform_scale), max(0.1, uniform_scale))

func popup(time: float) -> void:
	_visible = true;
	timer = Timer.new();
	timer.wait_time = time;
	timer.one_shot = true;
	timer.connect("timeout", _on_timer_timeout)

func _on_timer_timeout() -> void:
	_visible = false;
