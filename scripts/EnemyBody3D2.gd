extends CharacterBody3D

var player_detected = false
var player_position = Vector3()
var speed = 5.0
var gravity = -0.1 


func _ready():
	# Assuming 'Area3D' is the correct node name. Adjust if it's different.
	var area = $Area3D
	#area.connect("body_entered", self, "_on_area_3d_body_entered")
	#area.connect("body_exited", self, "_on_area_3d_body_exited")

func _on_area_3d_body_entered(body):
	if body.name == "CharacterBody3D": # Make sure to replace this with your player's node name
		player_detected = true
		player_position = body.global_transform.origin

func _on_area_3d_body_exited(body):
	if body.name == "CharacterBody3D": # Make sure to replace this with your player's node name
		player_detected = false

func _physics_process(delta):
	if player_detected:
		var direction = player_position - global_transform.origin
		direction.y = 0 # Keep the movement horizontal
		direction = direction.normalized()
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = 0
		velocity.z = 0

	# Gravity is applied separately to ensure it affects the character
	velocity.y += gravity * delta

	# move_and_slide expects velocity as the first parameter
	move_and_slide()
