extends CharacterBody2D
class_name Partygoer

@onready var mover = $Components/CharacterMover
@onready var vision_cone = $VisionCone2D
@onready var animator = $AnimatedSprite2D
@onready var state_machine = $StateMachine
@onready var direction_timer = $Timers/WaitTimer
@onready var boredom_timer = $Timers/BoredomTimer
@onready var rotation_timer = $Timers/RotationTimer
@onready var dialogue_displayer = $DialogueDisplayer
@onready var head_pivot = $HeadPivot
@onready var neck = $AnimatedSprite2D/Neck
@onready var exclamation = $Exclamation
@onready var head = $HeadPivot/Head

@export var head_rotation_amount = 1
var conversation_leader = false
var points_of_interest = []
var target: Node2D
var last_seen: Vector2
var cone_rotation_offset
var flipped = false

var default_modulate

func _ready() -> void:
	mover.init(self)
	cone_rotation_offset = vision_cone.rotation
	points_of_interest = get_tree().get_nodes_in_group("PointsOfInterest")
	neck.global_position = head_pivot.global_position
	head_pivot.global_position = neck.global_position
	head_rotation_amount = deg_to_rad(head_rotation_amount)
	default_modulate = head.modulate
	
func change_direction_helper(new_direction):
	flip_sprite_on_direction(new_direction)
	rotate_head(new_direction.angle())

func rotate_head(angle):
	vision_cone.rotation = angle + cone_rotation_offset
	head_pivot.rotate_clamped(angle)

func push_head(amount):
	head_pivot.push_rotation(amount)
	vision_cone.rotation += amount * head_pivot.get_direction()
	
## TODO: maybe move to an animator class later	
func flip_sprite_on_direction(direction):
	if direction.x < 0 and not flipped:
		animator.scale.x *= -1
		flipped = true
		head_pivot.global_position = neck.global_position
	elif direction.x >= 0 and flipped:
		animator.scale.x = abs(animator.scale.x)
		flipped = false
		head_pivot.global_position = neck.global_position

func set_transparency(amount):
	head.modulate = Color(default_modulate[0], default_modulate[1], default_modulate[2], amount)
	animator.modulate = Color(default_modulate[0], default_modulate[1], default_modulate[2], amount)

func fade_out(speed):
	head.modulate = lerp(head.modulate, Color.TRANSPARENT, speed)
	animator.modulate = lerp(animator.modulate, Color.TRANSPARENT, speed)

func fade_in(speed):
	head.modulate = lerp(head.modulate, default_modulate, speed)
	animator.modulate = lerp(animator.modulate, default_modulate, speed)
	
func set_colour_off_type_of_partier(body):
	if body.is_in_group("Player"):
		change_cone_colour(Globals.ConeHas.SEEN_PLAYER)
	else:
		change_cone_colour(Globals.ConeHas.SEEN_PARTYGOER)
		
func go_towards_target(partier):
	set_target(partier)
	set_colour_off_type_of_partier(partier)
	state_machine._transition_to_next_state("Approaching")
	

		
func _on_vision_cone_2d_entered_vision_cone(body: Variant) -> void:
	if state_machine.state.has_method("handle_seeing_something"):
		state_machine.state.handle_seeing_something(body)


func _on_vision_cone_2d_exited_vision_cone(body: Variant) -> void:
	if state_machine.state.has_method("handle_no_longer_seeing_something"):
		state_machine.state.handle_no_longer_seeing_something(body)
		
func move_to_target(speed):
	var direction = (target.global_position - global_position).normalized()
	mover.move_direction_at_speed(direction, speed)
	change_direction_helper(direction)

func _on_change_direction_timer_timeout() -> void:
	if state_machine.state.has_method("change_direction"):
		state_machine.state.change_direction()

func set_target(target):
	self.target = target

func change_cone_colour(state):
	vision_cone.change_vision_cone_colour(state)
	
func _on_boredom_timer_timeout() -> void:
	if state_machine.state.has_method("handle_boredom_tick"):
		state_machine.state.handle_boredom_tick()

func _on_dialogue_displayer_finished_showing_text() -> void:
	if state_machine.state.has_method("handle_finished_dialogue"):
		state_machine.state.handle_finished_dialogue()

func say_rant():
	dialogue_displayer.display_text(Dialogues.rants.pick_random())
	
func say_concerned():
	dialogue_displayer.display_text(Dialogues.player_initiators.pick_random())

func say_response():
	dialogue_displayer.display_text(Dialogues.responses.pick_random())

func say_intro():
	dialogue_displayer.display_text(Dialogues.intro_words.pick_random())
	
func _on_rotation_timer_timeout() -> void:
	if state_machine.state.has_method("handle_head_pushing"):
		state_machine.state.handle_head_pushing()


func _on_spawn_timer_timeout() -> void:
	if state_machine.state.has_method("handle_spawn_timer_over"):
		state_machine.state.handle_spawn_timer_over()
