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

enum {
	WON
	LOST
}

var state = ROAM
var menuState = BASE

onready var label0 = $Battle/BattleSelections/Move1
onready var label1 = $Battle/BattleSelections/Move2
onready var label2 = $Battle/BattleSelections/Move3
onready var label3 = $Battle/BattleSelections/Move4
onready var Player = $Battle/Path2D2/PathFollow2D/Player/MonsterController
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _process(delta):
	match (state):
		ROAM:
			$Battle.visible = false
			$Roam.visible = true
			
		BATTLE:
			$Roam.visible = false
			$Battle.visible = true
			
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
			print("not printing")
			label0.text = Player.getMove(0)
			label1.text = Player.getMove(1)
			label2.text = Player.getMove(2)
			label3.text = Player.getMove(3)
			
		ITEMS:
			pass
			
		SWITCH:
			pass
			
		RUN:
			if randi() % 2 == 0:
				_endBattle(LOST)

func _endBattle(condition):
	match(condition):
		WON:
			pass
		LOST:
			state = ROAM
