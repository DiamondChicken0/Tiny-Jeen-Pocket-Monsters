extends YSort

onready var camera = $RoamCamera
onready var bounds = $Bounds
var cameraVector = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_North_body_entered(body):
	cameraVector = Vector2.ZERO
	print("n")
	camera.make_current()
	cameraVector.x = camera.position.x
	cameraVector.y = camera.position.y - 288
	camera.position = cameraVector
	bounds.position.y -= 288

func _on_East_body_entered(body):
	cameraVector = Vector2.ZERO
	print("e")
	camera.make_current()
	cameraVector.x = camera.position.x + 320
	cameraVector.y = camera.position.y
	camera.position = cameraVector
	bounds.position.x += 320


func _on_South_body_entered(body):
	cameraVector = Vector2.ZERO
	print("s")
	camera.make_current()
	cameraVector.x = camera.position.x
	cameraVector.y = camera.position.y + 288
	camera.position = cameraVector
	bounds.position.y += 288


func _on_West_body_entered(body):
	cameraVector = Vector2.ZERO
	print("w")
	camera.make_current()
	cameraVector.x = camera.position.x - 320
	cameraVector.y = camera.position.y
	camera.position = cameraVector
	bounds.position.x -= 320
