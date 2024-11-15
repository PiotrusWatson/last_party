extends RayCast2D

@onready var animator = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.


func aim(target):
	look_at(target)

func fire_arm():
	animator.play("close")
	force_raycast_update()
	return get_collider()
	
func get_pos():
	return to_global(target_position)

func release_arm():
	animator.play("open")
