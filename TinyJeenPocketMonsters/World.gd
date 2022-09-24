extends Node2D

enum {
	PLAYER
	ENEMY
}

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
var turnState = PLAYER
signal update

onready var label0 = $Battle/Control/Move1
onready var label1 = $Battle/Control/Move2
onready var label2 = $Battle/Control/Move3
onready var label3 = $Battle/Control/Move4
onready var Player = $Battle/Path2D2/PathFollow2D/Player/MonsterController
onready var Enemy = $Battle/Path2D/EnemyPath/Enemy/EnemyController

var textTemp
var damage
# Called when the node enters the scene tree for the first time.
func _ready():
	$Battle/Control/Sprite/Textbox.valign = VALIGN_CENTER
	$Battle/Control/Sprite/Textbox.align = HALIGN_CENTER


func _process(delta):
	if Input.is_action_just_pressed("Accept"):
		$Battle/Control/Sprite.visible = false
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
			if Player.potions != 0:
				label0.text = str(Player.potions)
			else:
				label0.text = "0"
			label0.text += " POTIONS"
			
			if Player.bracelets != 0:
				label1.text = str(Player.bracelets)
			else:
				label1.text = "0"
			label1.text += " FBRACE"
			
			label2.text = ""
			label3.text = ""
			
		SWITCH:
			label0.text = Player.playerPartyNames[0]
			if Player.playerPartyNames[1] != null:
				label1.text = Player.playerPartyNames[1]
			else:
				label1.text = ""
				
			if Player.playerPartyNames[2] != null:
				label2.text = Player.playerPartyNames[2]
			else:
				label2.text = ""
				
			if Player.playerPartyNames[3] != null:
				label3.text = Player.playerPartyNames[3]
			else:
				label3.text = ""
				
			
		RUN:
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
			match (menuState):
				BASE:
					menuState = FIGHT
					
				FIGHT:
					_onMoveUse(PLAYER,Player.move0pwr, Player.move0acc, Player.move0type, Player.move0name)
					
				ITEMS:
					if Player.potions != 0 && Player.CurrentHP != Player.HP:
						_heal(PLAYER, 25, "POTION")
						Player.potions -= 1
					
				SWITCH:
					if Player.PlayerName != Player.playerPartyNames[0]:
						Player.monster = Player.nameDict[Player.playerPartyNames[0]]
						Player.moveChange = true
			
		1:
			match (menuState):
				BASE:
					menuState = ITEMS
				
				FIGHT:
					_onMoveUse(PLAYER,Player.move1pwr, Player.move1acc, Player.move1type, Player.move1name)
					
				ITEMS:
					Player.playerParty.find(null)
					if randi() % 3 == 0 && Player.bracelets != 0:
						if Player.playerParty.find(null) != -1:
							Player.playerParty[Player.playerParty.find(null)] = Enemy.monster
							Player.playerPartyNames[Player.playerParty.find(null)] = Enemy.EnemyName
							Player.bracelets -= 1
							textTemp = Enemy.EnemyName + " IS NOW A FRIEND"
							_textBox(textTemp)
					elif Player.bracelets == 0:
						_textBox("NO BRACELETS LEFT")
					else:
						textTemp = Enemy.EnemyName + " IS MEAN!"
						_textBox(textTemp)
				SWITCH:
					if Player.PlayerName != Player.playerPartyNames[1]:
						Player.monster = Player.nameDict[Player.playerPartyNames[1]]
						Player.moveChange = true
			
		2: 
			match (menuState):
				BASE:
					menuState = SWITCH
					
				FIGHT:
					_onMoveUse(PLAYER,Player.move2pwr, Player.move2acc, Player.move2type, Player.move2name)
					
				ITEMS:
					pass
					
				SWITCH:
					if Player.PlayerName != Player.playerPartyNames[2]:
						Player.monster = Player.nameDict[Player.playerPartyNames[2]]
						Player.moveChange = true
		
		3:
			match (menuState):
				BASE:
					if randi() % 2 == 0:
						menuState = RUN
				FIGHT:
					_onMoveUse(PLAYER,Player.move3pwr, Player.move3acc, Player.move3type, Player.move3name)
					
				ITEMS:
					pass
					
				SWITCH:
					if Player.PlayerName != Player.playerPartyNames[3]:
						Player.monster = Player.nameDict[Player.playerPartyNames[3]]
						Player.moveChange = true
						
						
	if turnState == PLAYER:
		turnState = ENEMY
	else:
		turnState = PLAYER
	_updateLabels()

func _heal(user, healing, name):
	if user == 0:
		if (Player.CurrentHP + healing <= Player.HP):
				Player.CurrentHP += healing
		else:
			Player.CurrentHP = Player.HP
		_textBox("RED USED A POTION")
	else:
		if (Enemy.CurrentHP + healing <= Enemy.HP):
				Enemy.CurrentHP += healing
		else:
			Enemy.CurrentHP = Enemy.HP
			textTemp = Enemy.EnemyName + " USED A POTION"
		_textBox(textTemp)
			

func _textBox(text):
	$Battle/Control/Sprite.visible = true
	$Battle/Control/Sprite/Textbox.text = text
	
func _onMoveUse(user, power, acc, type, name):
	if user == 0:
		if type == 0:
			damage = Player.Atk * power * 0.05
		else:
			damage = Player.SpATK * power * 0.05
			
		damage = floor(damage)
		
		if (Enemy.CurrentHP - damage >= 1):
			Enemy.CurrentHP -= damage
		else:
			Enemy.CurrentHP = 0
			
		
	turnState = ENEMY
		
	
	if user == 1:
		if type == 0:
			damage = Enemy.Atk * power * 0.05
		else:
			damage = Enemy.SpATK * power * 0.05
			
		damage = floor(damage)
		
		if (Player.CurrentHP - damage >= 1):
			Player.CurrentHP -= damage
		else:
			Player.CurrentHP = 0
			
	turnState = PLAYER
	

func _on_Move1_pressed():
	_ButtonState(0)


func _on_Move2_pressed():
	_ButtonState(1)


func _on_Move3_pressed():
	_ButtonState(2)


func _on_Move4_pressed():
	_ButtonState(3)


func _on_Back1_pressed():
	menuState = BASE


func _on_Back2_pressed():
	menuState = BASE
