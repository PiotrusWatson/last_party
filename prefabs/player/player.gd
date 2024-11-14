extends RigidBody2D

@onready var mover = $Components/PhysicsMover
@onready var anxiety_timer = $Timers/AnxietyDamage
@onready var health = $Components/Health
var direction = Vector2.ZERO
var body_count = 0

@export var anxiety_damage = 5
signal personal_space_violated
signal personal_space_freed
signal anxiety_changed(health)
signal dead
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mover.init(self)
	anxiety_changed.emit(health.health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	mover.push_direction(direction)

func _unhandled_input(event: InputEvent) -> void:
	var horizontal = Input.get_axis("Left", "Right")
	var vertical = Input.get_axis("Up", "Down")
	direction = Vector2(horizontal, vertical)
	


func _on_personal_space_body_entered(body: Node2D) -> void:
	if body.is_in_group("Partiers") and body != self:
		personal_space_violated.emit()
		if body_count == 0:
			anxiety_timer.start()
		body_count += 1
		
		

		
func _on_personal_space_body_exited(body: Node2D) -> void:
	if body.is_in_group("Partiers") and body != self:
		personal_space_freed.emit()
		body_count -= 1
		if body_count == 0:
			anxiety_timer.stop()


func _on_anxiety_damage_timeout() -> void:
	health.damage(anxiety_damage * body_count)
	anxiety_changed.emit(health.health)


func _on_health_dead() -> void:
	dead.emit()
