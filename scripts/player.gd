class_name Player extends CharacterBody2D

@export var Obj_Ball: Ball
@export var Is_NPC : bool

@export var Max_Speed: float 
@export var Ini_Speed: float
@export var Acceleration: float

var Heigth_Ajust: float

func _ready() -> void:
	Heigth_Ajust = global_position.y

func _physics_process(_delta: float) -> void:
	self.global_position.y = Heigth_Ajust
	if Is_NPC:
		if abs(Obj_Ball.global_position.x - global_position.x) < 30:
			velocity = Vector2(0, 0) 
		elif Obj_Ball.global_position.x > global_position.x:
			_get_new_speed(1)
		else:
			_get_new_speed(-1)
	else:	
		if Input.is_action_pressed("Derecha") and Input.is_action_pressed("Izquierda"):
			velocity = Vector2(0, 0)
		elif Input.is_action_pressed("Derecha"):
			_get_new_speed(1)
		elif Input.is_action_pressed("Izquierda"):
			_get_new_speed(-1)
		else:
			velocity = Vector2(0, 0)
	move_and_slide()

func _get_new_speed(direction: int) -> void:
	if (velocity.length() == 0 or velocity.dot(Vector2(direction, 0)) < 0):
		velocity = Vector2(Ini_Speed * direction, 0)
	else :
		velocity = Vector2(clamp(velocity.x + Acceleration * direction, Max_Speed * -1, Max_Speed ) , 0)
