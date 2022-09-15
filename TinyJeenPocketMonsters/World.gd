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
signal update

onready var label0 = $Battle/Control/Move1
onready var label1 = $Battle/Control/Move2
onready var label2 = $Battle/Control/Move3
onready var label3 = $Battle/Control/Move4
onready var Player = $Battle/Path2D2/PathFollow2D/Player/MonsterController
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _process(delta):
	_updateLabels()
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



func _updateLabels():
	match menuState:
		BASE:
			label0.text = "FIGHT"
			label1.text = "ITEMS"
			label2.text = "SWITCH"
			label3.text = "RUN"
			
		FIGHT:
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
				
	emit_signal("update")

func _endBattle(condition):
	match(condition):
		WON:
			pass
		LOST:
			state = ROAM


func _ButtonState(event):
	match event:
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


func _on_Move1_pressed():
	_ButtonState(0)


func _on_Move2_pressed():
	_ButtonState(1)


func _on_Move3_pressed():
	_ButtonState(2)


func _on_Move4_pressed():
	_ButtonState(3)
