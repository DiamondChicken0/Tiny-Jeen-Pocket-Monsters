extends Node

var newTexture = load("res://Charminder.png")
var moveChange = true
var type1 = NORMAL
var type2 = FIRE
var HP = 1
var CurrentHP = 1
var Atk = 1
var SpATK = 1
var Def = 1
var SpDef = 1
var Spd = 1
var Moves = "AB~~"
var move0name = "Blank"
var move0pwr = 1
var move0acc = 1
var move0type = 1
var move1name = "Blank"
var move1pwr = 1
var move1acc = 1
var move1type = 1
var move2name = "Blank"
var move2pwr = 1
var move2acc = 1
var move2type = 1
var move3name = "Blank"
var move3pwr = 1
var move3acc = 1
var move3type = 1
var playerMoves = ["AB~~", "AB~~", "AB~~", "AB~~"]
var playerParty = [SQUEERE, null, null, null]
var playerPartyNames = ["SQUEERE",null,null,null]
var potions = 3
var bracelets = 2



enum {
	CHARMINDER
	MINKEY
	SQUEERE
}


var nameDict : Dictionary = {
	"CHARMINDER" : CHARMINDER,
	"SQUEERE" : SQUEERE
}
enum {
	NORMAL
	FIRE
	WATER
	GRASS
}



var monster = SQUEERE
var PlayerName = "CHARMINDER"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func getMove(moveNum):
	match(moveNum):
		0:
			return move0name
		1:
			return move1name
		2: 
			return move2name
		3:
			return move3name
			
func assignMove(moveNum, name, pwr, acc, type):
	if !(name == move0name or name == move1name or name == move2name or name == move3name):
		match(moveNum):
			0:
				move0name = name
				move0pwr = pwr
				move0acc = acc
				move0type = type
				
			1:
				move1name = name
				move1pwr = pwr
				move1acc = acc
				move1type = type
				
			2:
				move2name = name
				move2pwr = pwr
				move2acc = acc
				move2type = type
				
			3:
				move3name = name
				move3pwr = pwr
				move3acc = acc
				move3type = type
	else:
		print ("Move Already Learned!")
	print (move0name + " " + move1name + " " + move2name + " " + move3name)
	
func _process(delta):
	if moveChange:
		match (monster):
			CHARMINDER:
				PlayerName = "CHARMINDER"
				get_parent().texture = load("res://Charminder.png")
				type1 = FIRE
				HP = 25
				CurrentHP = 25
				Atk = 6
				SpATK = 7
				Def = 4
				SpDef = 4
				Spd = 6
				
				for i in 4:
					match (Moves.substr(i,1)):
						"A":
							assignMove(i, "WRESTLE", 40, 95, NORMAL)
							
						"B":
							assignMove(i, "FIRE", 50, 80, FIRE)
					moveChange = false
				
					
				
			MINKEY:
				PlayerName = "MINKEY"
				get_parent().texture = load("res://Minkey.png")
				type1 = NORMAL
				CurrentHP = 30
				HP = 30
				Atk = 8
				SpATK = 3
				Def = 5
				SpDef = 3
				Spd = 5
				
			SQUEERE:
				PlayerName = "SQUEERE"
				get_parent().texture = load("res://Squuere.png")
				type1 = WATER
				CurrentHP = 32
				HP = 32
				Atk = 3
				SpATK = 7
				Def = 6
				SpDef = 6
				Spd = 2
				
				for i in 4:
					match (Moves.substr(i,1)):
						"A":
							assignMove(i, "WRESTLE", 40, 95, NORMAL)
							
						"B":
							assignMove(i, "SQUIRT", 50, 80, WATER)
				moveChange = false
			_:
				pass
		
