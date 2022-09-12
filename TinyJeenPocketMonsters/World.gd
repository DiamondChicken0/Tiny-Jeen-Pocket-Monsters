extends Node2D

enum {
	ROAM
	BATTLE
	PAUSE
}

enum {
	BASE
	FIGHT
	ITEMS
	RUN
	SWITCH
}

var state = ROAM
var menuState = BASE

onready var label0 = $Battle/BattleSelections/Area2D/CollisionShape2D/Move1
onready var label1 = $Battle/BattleSelections/Area2D/CollisionShape2D2/Move2
onready var label2 = $Battle/BattleSelections/Area2D/CollisionShape2D3/Move3
onready var label3 = $Battle/BattleSelections/Area2D/CollisionShape2D4/Move4
onready var Enemy = $Battle/Path2D/PathFollow2D/Enemy
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


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
	_updateLabels()


func _on_Area2D_input_event(viewport, event, shape_idx):
	print(event)
	if Input.is_action_just_pressed("left_click") and state == BATTLE:
		match shape_idx:
			0:
				if menuState == BASE:
					menuState = FIGHT
				
			1:
				if menuState == BASE:
					menuState = ITEMS
				
			2: 
				if menuState == BASE:
					menuState = SWITCH
			
			3:
				if menuState == BASE:
					menuState = RUN
		
		_updateLabels()

func _updateLabels():
	match menuState:
		BASE:
			label0.text = "FIGHT"
			label1.text = "ITEMS"
			label2.text = "SWITCH"
			label3.text = "RUN"
			
		FIGHT:
			label0.text = Enemy.getMove(0)
			label1.text = Enemy.getMove(1)
			label2.text = Enemy.getMove(2)
			label3.text = Enemy.getMove(3)
			
		ITEMS:
			pass
			
		SWITCH:
			pass
			
		SWITCH:
			pass
