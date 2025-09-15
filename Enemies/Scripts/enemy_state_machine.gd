class_name EnemyStateMachine extends Node

var states : Array[ EnemyState ]
var prev_state : EnemyState
var current_state : EnemyState

func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED
	
func _process( _delta):
	change_state( current_state.process(_delta) )
	
func _physics_process( _delta):
	change_state( current_state.physics(_delta) )
	
func initialize( _enemy : Enemy ) -> void:
	states = []
	
	for child in get_children():
		if child is EnemyState:
			states.append(child)
	
	for s in states:
		s.enemy = _enemy
		s.state_machine = self
		s.init()
		
	if states.size() > 0:
		change_state( states[0] )
		process_mode = Node.PROCESS_MODE_INHERIT
	
func change_state( new_state : EnemyState ) -> void:
	if new_state == null || new_state == current_state:
		return
	
	if current_state:
		current_state.exit()

	prev_state = current_state
	current_state = new_state
	current_state.enter()
