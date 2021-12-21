extends Sprite


var speed = 60
var speed_x = 60
var speed_y = 60
var velocity = Vector2()
var direction_list = [-1,1]
var direction = 0
onready var screen_size = get_viewport_rect().size   


func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	randomize()
	init_speed()	
	velocity.x = direction_list[randi() % direction_list.size()]
	velocity.y = direction_list[randi() % direction_list.size()]
	if velocity.x == velocity.y && velocity.y == 0:
		velocity.x = 1
	

func _process(delta):
	pass #position = get_viewport().get_mouse_position()

func init_speed():
	speed = rand_range(30, 100)
	

func _physics_process(_delta):
	velocity = velocity.normalized()
	position += velocity  *speed* _delta

	var x = clamp(position.x, 30, screen_size.x-30)
	var y = clamp(position.y, 30, screen_size.y-30)
	if x <= 30 || x >= screen_size.x-30: 
		init_speed()
		velocity.x *= -1
		if velocity.y == 0:
			velocity.y = direction_list[randi() % direction_list.size()]
	if y <= 30 || y >= screen_size.y-30:
		init_speed()
		velocity.y *= -1
		if velocity.x == 0:
			velocity.x = direction_list[randi() % direction_list.size()]
	


func _on_TextureRect_resized():
	screen_size = get_viewport_rect().size 
