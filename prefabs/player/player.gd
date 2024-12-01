extends RigidBody2D
enum BodyParts{FEET = 0, HANDS = 1}

@onready var mover = $Components/PhysicsMover
@onready var anxiety_timer = $Timers/AnxietyDamage
@onready var health = $Components/Health
@onready var arm = $Arm
@onready var left_arm = $BodyParts/LeftArm
@onready var thrown_stuff = $ThrownStuff
@onready var thrower = $Components/Thrower

var direction = Vector2.ZERO
var body_count = 0
var can_interact = false
var thing_interacted_with = null
var max_health
var ammo
@export var max_ammo = 2
@export var anxiety_damage = 5
@export var beer_healing = 30

signal personal_space_violated
signal personal_space_freed
signal anxiety_changed(health)
signal dead
signal threw_thing(ammo)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mover.init(self)
	max_health = health.max_health
	anxiety_changed.emit(health.health)
	ammo = max_ammo
	thrower.init(thrown_stuff)

func _process(delta: float) -> void:
	arm.aim(get_global_mouse_position())
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	mover.push_direction(direction)
	left_arm.move_to_target(get_mouse_direction())
	
func get_mouse_direction():
	return (get_global_mouse_position() - global_position).normalized()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Fire"):
		arm.fire_arm()
		left_arm.stretch_to_target(get_mouse_direction())
	elif event.is_action_released("Fire"):
		var thing = arm.release_arm()
		if thing == null:
			return
		var push_direction = (global_position - arm.get_pos()).normalized()
		mover.push_direction(push_direction)
	
	if event.is_action_released("AltFire") and ammo > 0:
		thrower.throw_object(get_mouse_direction())
		ammo -= 1
		threw_thing.emit(ammo)
	
	if event.is_action_released("Interact") and can_interact:
		thing_interacted_with.interact()
	
func set_interactability(is_interactable, thing_interacted_with):
	can_interact = is_interactable
	if can_interact:
		self.thing_interacted_with = thing_interacted_with
	else:
		self.thing_interacted_with = null

func get_beer():
	left_arm.activate_beer(true)
		

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

func pickup():
	ammo += 1
	threw_thing.emit(ammo)

func _on_drinker_area_entered(area: Area2D) -> void:
	if area.is_in_group("Beer") and left_arm.beer_ready:
		health.damage(-beer_healing)
		left_arm.activate_beer(false)


func _on_thrower_threw_something(direction: Variant, speed: Variant) -> void:
	mover.push_direction_at_speed(direction, speed)
