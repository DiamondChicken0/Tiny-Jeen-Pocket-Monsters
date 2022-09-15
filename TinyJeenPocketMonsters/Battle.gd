extends YSort


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Control/PlayerReadout/PlayerHealth.text = str($Path2D2/PathFollow2D/Player/MonsterController.CurrentHP) + "/" + str($Path2D2/PathFollow2D/Player/MonsterController.HP)
	$Control/PlayerReadout/PlayerName.text = $Path2D2/PathFollow2D/Player/MonsterController.PlayerName


func _on_World_update():
	$Control/PlayerReadout/PlayerHealth.text = str($Path2D2/PathFollow2D/Player/MonsterController.CurrentHP) + "/" + str($Path2D2/PathFollow2D/Player/MonsterController.HP)
	$Control/PlayerReadout/PlayerName.text = $Path2D2/PathFollow2D/Player/MonsterController.PlayerName

