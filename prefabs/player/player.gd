extends RigidBody2D

@onready var mover = $Components/PhysicsMover
var direction = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mover.init(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	mover.push_direction(direction)

func _unhandled_input(event: InputEvent) -> void:
	var horizontal = Input.get_axis("Left", "Right")
	var vertical = Input.get_axis("Up", "Down")
	direction = Vector2(horizontal, vertical)
	
