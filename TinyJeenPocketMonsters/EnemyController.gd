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
var move0name = "BLANK"
var move0pwr
var move0acc
var move0type
var move1name = "BLANK"
var move1pwr
var move1acc
var move1type
var move2name = "BLANK"
var move2pwr
var move2acc
var move2type
var move3name = "BLANK"
var move3pwr
var move3acc
var move3type
var playerParty = [CHARMINDER]
var playerPartyNames = ["CHARMINDER",null,null,null]
var faintStates = [true, true, true, true]
var potions = 3
var bracelets = 2
var currentEXP = 0
var level = 5
var effects = FINE

enum {
	FINE
	ONFIRE
	FROZEN
	SHOCKED
	SLEEPY
}

enum {
	CHARMINDER
	MINKEY
	SQUARE
}

enum {
	NORMAL
	FIRE
	WATER
	GRASS
	ELECTRIC
	ICE
	FIGHTING
	POISON
	GROUND
	FLYING
	PSYCHIC
	BUG
	ROCK
	GHOST
	DRAGON
	DARK
	STEEL
	FAIRY
	NONE
}

var Weaknesses : Dictionary = {
	NORMAL : NONE,
	FIRE : WATER,
	WATER : GRASS,
	GRASS : FIRE,
	ELECTRIC : GRASS,
	ICE : FIRE,
	FIGHTING : POISON,
	POISON : ROCK,
	GROUND : BUG,
	FLYING : ELECTRIC,
	PSYCHIC : PSYCHIC,
	BUG : STEEL,
	ROCK : STEEL,
	GHOST : DARK,
	DRAGON : FAIRY,
	DARK : FAIRY,
	STEEL : FIRE,
	FAIRY : POISON
}

var Strengths : Dictionary = {
	NORMAL : NONE,
	FIRE : GRASS,
	WATER : FIRE,
	GRASS : WATER,
	ELECTRIC : FLYING,
	ICE : FIRE,
	FIGHTING : ROCK,
	POISON : BUG,
	GROUND : ELECTRIC,
	FLYING : FIGHTING,
	PSYCHIC : FIGHTING,
	BUG : FLYING,
	ROCK : ELECTRIC,
	GHOST : NORMAL,
	DRAGON : ICE,
	DARK : POISON,
	STEEL : FIGHTING,
	FAIRY : DARK
} 
var nameDict : Dictionary = {
	"CHARMINDER" : CHARMINDER,
	"SQUARE" : SQUARE
}


var monster = CHARMINDER
var EnemyName = "CHARMINDER"

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
				EnemyName = "CHARMINDER"
				get_parent().texture = load("res://Charminder.png")
				type1 = FIRE
				HP = 25 * ((level - 4) * 0.02 + 1)
				CurrentHP = HP
				Atk = 6 * ((level - 4) * 0.02 + 1)
				SpATK = 7 * ((level - 4) * 0.02 + 1)
				Def = 4 * ((level - 4) * 0.02 + 1) 
				SpDef = 4 * ((level - 4) * 0.02 + 1)
				Spd = 6 * ((level - 4) * 0.02 + 1)
				
				for i in 4:
					match (Moves.substr(i,1)):
						"A":
							assignMove(i, "WRESTLE", 40, 95, NORMAL)
							
						"B":
							assignMove(i, "FIRE", 50, 80, FIRE)
					moveChange = false
				
					
				
			MINKEY:
				EnemyName = "MINKEY"
				get_parent().texture = load("res://Minkey.png")
				type1 = NORMAL
				HP = 30 * ((level - 4) * 0.02 + 1)
				CurrentHP = HP
				Atk = 8 * ((level - 4) * 0.02 + 1)
				SpATK = 3 * ((level - 4) * 0.02 + 1)
				Def = 5 * ((level - 4) * 0.02 + 1)
				SpDef = 3 * ((level - 4) * 0.02 + 1)
				Spd = 5 * ((level - 4) * 0.02 + 1)
				
			SQUARE:
				EnemyName = "SQUARE"
				get_parent().texture = load("res://Square.png")
				type1 = WATER
				HP = 32 * ((level - 4) * 0.02 + 1)
				CurrentHP = HP
				Atk = 3 * ((level - 4) * 0.02 + 1)
				SpATK = 7 * ((level - 4) * 0.02 + 1)
				Def = 6 * ((level - 4) * 0.02 + 1)
				SpDef = 6 * ((level - 4) * 0.02 + 1)
				Spd = 2 * ((level - 4) * 0.02 + 1)
				
				for i in 4:
					match (Moves.substr(i,1)):
						"A":
							assignMove(i, "WRESTLE", 40, 95, NORMAL)
							
						"B":
							assignMove(i, "SQUIRT", 50, 80, WATER)
				moveChange = false
			
			_:
				pass

		faintStates[playerPartyNames.find(EnemyName)] = false
	
