extends Control

# Reference to the player (set in the editor or via code)
@export var player: CharacterBody2D
var camera: Camera2D

func _ready():
	visible = false  # Hide the pause screen initially
	camera = get_viewport().get_camera_2d()
	
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):  # Esc key by default
		toggle_pause()

func toggle_pause():
	if get_tree().paused:
		get_tree().paused = false
		visible = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		get_tree().paused = true
		visible = true
		align_with_character()  # Align when pausing
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$VBoxContainer/ResumeButton.grab_focus()

func align_with_character():
	if player and camera:
		# Get the player's world position
		var player_pos = player.global_position
		# Convert world position to screen coordinates
		var screen_pos = camera.get_screen_center_position() + (player_pos - camera.global_position)
		# Set the pause menu's position (or a child UI element)
		position = screen_pos
		# Optionally offset to center the UI on the character
		position -= size / 2  # Center the Control node on the character

func _on_resume_button_pressed():
	toggle_pause()  # Resume the game

func _on_restart_button_pressed():
	get_tree().paused = false  # Unpause before reloading
	get_tree().reload_current_scene()  # Restart the current scene

func _on_quit_button_pressed():
	get_tree().quit()
