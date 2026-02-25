extends CharacterBody2D

const SPEED = 32.0
const JUMP_VELOCITY = -160.0
var direction:int = -1
var can_move:bool = true
var timer = Timer.new()
@export var front_ray:RayCast2D
@export var floor_ray:RayCast2D

func jump() -> void:
	if is_on_floor():
		velocity.y = JUMP_VELOCITY

func move(_direction: int) -> void:
	velocity.x = _direction * SPEED

func facing_wall() -> void:
	scale.x *= -1
	can_move = false
	velocity.x -= SPEED * direction * 0.67
	await get_tree().create_timer(1.0).timeout
	direction *= -1
	can_move = true

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if front_ray.is_colliding():
		if front_ray.get_collider().name == "Player":
			print("follow the player")
		elif front_ray.get_collider().name == "Map_Manager":
			facing_wall()
	if !floor_ray.is_colliding():
		print("there is no floor!")
	
	if can_move:
		move(direction)
	move_and_slide()
