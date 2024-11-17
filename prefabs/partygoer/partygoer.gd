extends CharacterBody2D
class_name Partygoer

@onready var mover = $Components/CharacterMover
@onready var vision_cone = $VisionCone2D
@onready var animator = $AnimatedSprite2D
@onready var state_machine = $StateMachine
@onready var direction_timer = $Timers/WaitTimer
@onready var boredom_timer = $Timers/BoredomTimer
@onready var dialogue_displayer = $DialogueDisplayer
@onready var head_pivot = $HeadPivot
@onready var neck = $Neck

var thirst = 0
var restlessness = 0
var points_of_interest = []
var target: Node2D
var cone_rotation_offset
var flipped = false

func _ready() -> void:
	mover.init(self)
	cone_rotation_offset = vision_cone.rotation
	points_of_interest = get_tree().get_nodes_in_group("PointsOfInterest")
	head_pivot.global_position = neck.global_position
	
func change_direction_helper(new_direction):
	flip_sprite_on_direction(new_direction)
	vision_cone.rotation = new_direction.angle() + cone_rotation_offset
	head_pivot.rotate_clamped(new_direction.angle())
	
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
	
func _on_vision_cone_2d_entered_vision_cone(body: Variant) -> void:
	if state_machine.state.has_method("handle_seeing_something"):
		state_machine.state.handle_seeing_something(body)


func _on_vision_cone_2d_exited_vision_cone(body: Variant) -> void:
	if state_machine.state.has_method("handle_no_longer_seeing_something"):
		state_machine.state.handle_no_longer_seeing_something(body)


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
