extends CharacterBody2D
@onready var id = "player"

#Export makes this variable pop up in the properties in the node
#Move_speed is the variable for the character speed.  100 is 100%
@export var move_speed : float = 100

#This sets the player facing down. 
#This is how directions work in this game.
#(x, y) if the x is 1, then the player faces right, if it is -1, then they face left
#If the y is 1, then the character faces down, if it is -1, then they face up
@export var starting_direction : Vector2 = Vector2(0, 1)


@onready var animation_tree = $AnimationPlayer/AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")


#Update_animation takes the user input in (x, y) vector format and finds out what do with it
#If move input is not zero, standing still, it will take the (x, y) vector and assign it to the right animation we created in the animation player
func update_animation(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/idle/blend_position", move_input)
		animation_tree.set("parameters/walk/blend_position", move_input)
		
		
#animation_state_changer this changes the animation state.  We created two states idle and walking states.  This will change the state based off of the velocity.
func animation_state_changer():
	#If velocity is not zero, then walk, if zero, then idle
	if(velocity != Vector2.ZERO):
		animation_state.travel("walk")
	else:
		animation_state.travel("idle")
		
		
		
		
#_ready Runs when the instance is created, AKA rendered on screen
func _ready():
	update_animation(starting_direction)

#_physics_process is ALWAYS running
func _physics_process(_delta):
	
	
	#Getting input from player
	
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"), 
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	update_animation(input_direction)
	
	
	#Update the player velocity ALSO NORMALIZE INPUT DIRECTION TO FIX FASTER diagonal movement!!!
	velocity = input_direction.normalized() * move_speed
	
	#Move and slide fuction uses velocity to move character
	move_and_slide() #This will make collsions non sticky for the player
	#move_and_collide(velocity * _delta) #This is for sticking collision
	
	animation_state_changer()
	





