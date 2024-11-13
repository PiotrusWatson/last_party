extends PartygoerState

var current_direction: Vector2

func enter(previous_state_path: String, data := {}):
	current_direction = partygoer.get_global_transform().x
	partygoer.direction_timer.start()
	

func physics_process(delta):
	partygoer.mover.move_direction(current_direction)

func change_direction():
	current_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	flip_sprite_on_direction()
	partygoer.vision_cone.rotation = current_direction.angle() + partygoer.cone_rotation_offset
	
func handle_seeing_something(body):
	if body.is_in_group("Partier"):
		partygoer.set_target(body)
		finished.emit(APPROACHING)
		

func flip_sprite_on_direction():
	var animator = partygoer.animator as AnimatedSprite2D
	if current_direction.x < 0:
		animator.flip_h = true
	else:
		animator.flip_h = false
		
