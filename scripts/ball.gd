class_name Ball extends CharacterBody2D

var Start_Position : Vector2
@export var Speed : float = -200
@export var Max_Speed : float = 400
@export var Acceleration : float = 2

func _ready() -> void:
	Start_Position = global_position
	restart_ball()

func restart_ball() -> void:
	global_position = Start_Position
	velocity = Vector2(0, Speed)

func _physics_process(delta: float) -> void:	
	var collision:= move_and_collide(velocity * delta)
	if collision:
		var collider = collision.get_collider()
		if collider is Player:
			_bounce_off_paddle(collider)
		else:
			var normal = collision.get_normal()
			velocity = velocity.bounce(normal) + velocity.bounce(normal).normalized()

func _bounce_off_paddle(paddle : Node2D) -> void:
	var paddle_position = paddle.global_position
	var direction_to_ball = paddle_position.direction_to(self.global_position)
	
	var current_direction = velocity.normalized()
	var updated_direction = (direction_to_ball - current_direction).normalized()
	
	var current_speed = velocity.length() 
	current_speed = min(current_speed + Acceleration, Max_Speed)
	velocity = updated_direction * current_speed
