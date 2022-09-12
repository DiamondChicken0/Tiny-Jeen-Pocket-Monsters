extends Node

var newTexture = load("res://Charminder.png")
var moveChange = true
var HP = 1
var Atk = 1
var SpATK = 1
var Def = 1
var SpDef = 1
var Spd = 1
var Moves = "ABAA"
var move0name = "Blank"
var move0pwr
var move0acc
var move0type
var move1name = "Blank"
var move1pwr
var move1acc
var move1type
var move2name = "Blank"
var move2pwr
var move2acc
var move2type
var move3name = "Blank"
var move3pwr
var move3acc
var move3type



enum {
	CHARMINDER
	MINKEY
}

enum {
	NORMAL
	FIRE
	WATER
	GRASS
}

export var monster = CHARMINDER

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
	
func _process(delta):

	if moveChange:
		match (monster):
			CHARMINDER:
				get_parent().texture = newTexture
				HP = 25
				Atk = 6
				SpATK = 7
				Def = 4
				SpDef = 4
				Spd = 6
				
				for i in 4:
					match (Moves.substr(i,i)):
						"A":
							assignMove(i, "Punch", 40, 95, NORMAL)
							
						"B":
							assignMove(i, "Ember", 50, 80, FIRE)
							
				moveChange = false
				
			MINKEY:
				Atk = 8
				SpATK = 3
				Def = 5
				SpDef = 3
				Spd = 5
				
			_:
				pass
				

