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

var battleEnd = false
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
var emptyParty = true
var textTemp
var damage
var exit = false
var proposedMove = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	$Battle/Control/Sprite/Textbox.valign = VALIGN_CENTER
	$Battle/Control/Sprite/Textbox.align = HALIGN_CENTER
	$Roam/Player/RoamCamera.make_current()


func _process(delta):
	_updateLabels()
	if Input.is_action_just_pressed("Accept"):
		$Battle/Control/Sprite.visible = false
		$Battle/Control/Back1.disabled = false
		$Battle/Control/Back2.disabled = false
		$Battle/Control/Move1.disabled = false
		$Battle/Control/Move2.disabled = false
		$Battle/Control/Move3.disabled = false
		$Battle/Control/Move4.disabled = false
		if exit:
			state = ROAM
			exit = false
			$Roam/Player/RoamCamera.make_current()
	
	match (state):
		ROAM:
			$Roam.visible = true
			$Battle.visible = false
			
		BATTLE:
			if battleEnd == false:
				$Battle/BattleCamera.make_current()
				$Roam.visible = false
				$Battle.visible = true
				if turnState == ENEMY:
					if Enemy.currentEXP < Player.currentEXP * 0.8:
						if Enemy.move0type == Player.Weaknesses[Player.type1]:
							if randi() % 5 != 0:
								proposedMove = 0
						if Enemy.move1name != "BLANK" and Enemy.move1type == Player.Weaknesses[Player.type1]:
							if randi() % 5 != 1:
								proposedMove = 1
						if Enemy.move2name != "BLANK" and Enemy.move2type == Player.Weaknesses[Player.type1]:
							if randi() % 5 != 2:
								proposedMove = 2
						if Enemy.move3name != "BLANK" and Enemy.move3type == Player.Weaknesses[Player.type1]:
							if randi() % 5 != 3:
								proposedMove = 3
								
					elif Enemy.currentEXP > Player.currentEXP * 1.2:
						if Player.effects != 0:
							if Enemy.move0type == 18:
								if randi() % 5 != 0:
									proposedMove = 0
							if Enemy.move1name != "BLANK" and Enemy.move1type == 18:
								if randi() % 5 != 1:
									proposedMove = 1
							if Enemy.move2name != "BLANK" and Enemy.move2type == 18:
								if randi() % 5 != 2:
									proposedMove = 2
							if Enemy.move3name != "BLANK" and Enemy.move3type == 18:
								if randi() % 5 != 3:
									proposedMove = 3
						else:
							if Enemy.move0type == Player.Weaknesses[Player.type1]:
								if randi() % 5 != 0:
									proposedMove = 0
							if Enemy.move1name != "BLANK" and Enemy.move1type == Player.Weaknesses[Player.type1]:
								if randi() % 5 != 1:
									proposedMove = 1
							if Enemy.move2name != "BLANK" and Enemy.move2type == Player.Weaknesses[Player.type1]:
								if randi() % 5 != 2:
									proposedMove = 2
							if Enemy.move3name != "BLANK" and Enemy.move3type == Player.Weaknesses[Player.type1]:
								if randi() % 5 != 3:
									proposedMove = 3
									
					if proposedMove == 5:
						if randi() % 1 == 1:
							_heal(1, 20, "POTION")
							proposedMove = -1
						else:
							randomize()
							proposedMove = randi() % 3
							
		PAUSE:
			pass

func _on_Player_StartBattle():
	state = BATTLE
	_updateLabels()

func _updateLabels():
	#Remember to fix this fuckhead 
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
	battleEnd = true
	match(condition):
		WON:
			Player._expGain(5 )
			_textBox("YOU HAVE WON!")
			exit = true
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
					randomize()
					if randi() % 3 == 0 && Player.bracelets != 0:
						if Player.playerParty.find(null) != -1:
							Player.playerParty[Player.playerParty.find(null)] = Enemy.monster
							Player.playerPartyNames[Player.playerPartyNames.find(null)] = Enemy.EnemyName
							Player.bracelets -= 1
							textTemp = Enemy.EnemyName + " IS NOW A FRIEND"
							_textBox(textTemp)
					elif Player.bracelets == 0:
						_textBox("NO BRACELETS LEFT")
					else:
						textTemp = Enemy.EnemyName + " IS MEAN!"
						Player.bracelets -= 1
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
	_turnStateChange()
			

func _textBox(text):
	$Battle/Control/Sprite.visible = true
	$Battle/Control/Sprite/Textbox.text = text
	$Battle/Control/Back1.disabled = true
	$Battle/Control/Back2.disabled = true
	$Battle/Control/Move1.disabled = true
	$Battle/Control/Move2.disabled = true
	$Battle/Control/Move3.disabled = true
	$Battle/Control/Move4.disabled = true

func _onMoveUse(user, power, acc, type, name):
	if user == 0:
		if type == 0:
			damage = Player.Atk * power * 0.05
		else:
			damage = Player.SpATK * power * 0.04
			if Enemy.Weaknesses[Enemy.type1] == type:
				damage *= 1.2
				
			if Enemy.Strengths[Enemy.type1] == type:
				damage *= 0.8
				
		damage = floor(damage)
		
		if name != "BLANK":
			_textBox("YOU USED " + name)
		else:
			_textBox("YOU FLAIL AROUND USELESSLY")
		
		if (Enemy.CurrentHP - damage >= 1):
			Enemy.CurrentHP -= damage
		else:
			Enemy.CurrentHP = 0
		
	if user == 1:
		if type == 0:
			damage = Enemy.Atk * power * 0.05
		else:
			damage = Enemy.SpATK * power * 0.04
			
			if Player.Weaknesses[Player.type1] == type:
				damage *= 1.2
				
			if Player.Strengths[Player.type1] == type:
				damage *= 0.8
				
		damage = floor(damage)
		
		if (Player.CurrentHP - damage >= 1):
			Player.CurrentHP -= damage
		else:
			Player.CurrentHP = 0
	
	if Enemy.CurrentHP == 0 and Enemy.faintStates[Enemy.playerPartyNames.find(Enemy.EnemyName)] == false:
		_faint(ENEMY)
	
	if Player.CurrentHP == 0 and Player.faintStates[Player.playerPartyNames.find(Player.PlayerName)] == false:
		_faint(PLAYER)
	
	Enemy.CurrentHP = round(Enemy.CurrentHP)
	Player.CurrentHP = round(Player.CurrentHP)
	_turnStateChange()
	
func _turnStateChange():
	
	if turnState == PLAYER:
		turnState = ENEMY
	else:
		turnState = PLAYER
		
func _faint(user):
	$Battle/PlayerDeath.frame = 0
	$Battle/EnemyDeath.frame = 0
	if user == ENEMY:
		$Battle/Path2D.visible = false
		$Battle/EnemyDeath.visible = true
		$Battle/EnemyDeath.play("default")
		Enemy.faintStates[Enemy.playerPartyNames.find(Enemy.EnemyName)] = true
		
	if user == PLAYER:
		$Battle/Path2D2.visible = false
		$Battle/PlayerDeath.visible = true
		$Battle/EnemyDeath.play("default")
		Player.faintStates[Player.playerPartyNames.find(Player.PlayerName)] = true
		
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


func _on_PlayerDeath_animation_finished():
	
	$Battle/PlayerDeath.visible = false
	
	if Player.faintStates.find(false) == -1:
		_endBattle(LOST)

func _on_EnemyDeath_animation_finished():
	
	$Battle/EnemyDeath.visible = false

	if Enemy.faintStates.find(false) == -1:
		_endBattle(WON)

