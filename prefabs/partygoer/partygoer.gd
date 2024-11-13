extends CharacterBody2D
class_name Partygoer

@onready var mover = $Components/CharacterMover
@onready var vision_cone = $VisionCone2D
@onready var animator = $AnimatedSprite2D
@onready var state_machine = $StateMachine
@onready var direction_timer = $Timers/ChangeDirectionTimer

@export var distance_to_stop = 0.5
var target: Node2D
var cone_rotation_offset
func _ready() -> void:
	mover.init(self)
	cone_rotation_offset = vision_cone.rotation
	
	
func change_direction_helper(new_direction):
	flip_sprite_on_direction(new_direction)
	vision_cone.rotation = new_direction.angle() + cone_rotation_offset

## TODO: maybe move to an animator class later	
func flip_sprite_on_direction(direction):
	if direction.x < 0:
		animator.flip_h = true
	else:
		animator.flip_h = false
	
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
