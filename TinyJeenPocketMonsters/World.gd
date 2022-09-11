extends Node2D

enum {
	ROAM
	BATTLE
	PAUSE
}

var state = ROAM

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	
	match (state):
		ROAM:
			pass
			
		BATTLE:
			$Roam.visible = false
		PAUSE:
			pass	
			




func _on_Player_StartBattle():
	state = BATTLE
	
func _attack(moveNum):
	


func _on_Area2D_input_event(viewport, event, shape_idx):
	print(event)
	if Input.is_action_just_pressed("left_click"):
		match shape_idx:
			0:
				pass
				
			1:
				pass
				
			2: 
				pass
			
			3:
				pass
