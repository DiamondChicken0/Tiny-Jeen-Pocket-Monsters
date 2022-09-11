extends KinematicBody2D

var input_vector = Vector2.ZERO
var velocity = Vector2.ZERO
signal StartBattle
func _ready():
	pass 


func _process(delta):
	if $"..".visible == true: 
		input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		input_vector = input_vector.normalized()
	
		if input_vector != Vector2.ZERO:
			velocity = velocity.move_toward(input_vector * 50, 2000 * delta)
		else:
			velocity = Vector2.ZERO
	
		velocity = move_and_slide(velocity)
	
		if (get_slide_count() >= 1):
			emit_signal("StartBattle")
			
	else:
		pass
	
