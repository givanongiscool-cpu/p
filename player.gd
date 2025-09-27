extends CharacterBody2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var weapon_equip: bool
func _ready():
	weapon_equip = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		 
	move_and_slide()
	
	handle_movement_animation(direction)
	handle_attack_animation()

func handle_attack_animation():	
	if Input.is_action_just_pressed("attack"):
		animated_sprite.play("attack right")
	
	
func handle_movement_animation(dir):
		if dir != 0: # player is moving left/right
			animated_sprite.play("right")
			animated_sprite.flip_h = dir < 0  # flip sprite when moving left
			
		else:
			if Input.is_action_just_pressed("attack") && dir != 0:
				animated_sprite.play("idle")
				
				
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	

	
