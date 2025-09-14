class_name HurtBox extends Area2D

@export var damage : int = 1

func _ready():
	area_entered.connect( AreaEntered )
	
func _process(delta):
	pass

func AreaEntered( area : Area2D ) -> void:
	if area is HitBox:
		area.TakeDamage( damage )
