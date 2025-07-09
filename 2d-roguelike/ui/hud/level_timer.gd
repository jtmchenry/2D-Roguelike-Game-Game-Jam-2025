extends CanvasLayer

@onready var survival_timer: Timer = $SurvivalTimer
@onready var countdown_label: Label = $CountdownLabel

var time_left: float

func _ready():
	if Game.current_level == 1:
		survival_timer.wait_time = 30.0
	elif Game.current_level == 2:
		survival_timer.wait_time = 40.0
	elif Game.current_level == 3:
		survival_timer.wait_time = 45.0
	time_left = survival_timer.wait_time
	survival_timer.start()

func _process(delta):
	if survival_timer.is_stopped():
		return
	
	time_left -= delta
	var time_display = int(ceil(time_left))
	countdown_label.text = str(time_display)
	
	var base_size = 60
	
	# Change appearance in last 5 seconds
	if time_display <= 5:
		# Make text color more red
		var t = clamp(1.0 - (time_left / 5.0), 0.0, 1.0)
		var color = Color(1.0, 1.0 - t, 1.0 - t)  # From white to red
		countdown_label.add_theme_color_override("font_color", color)

		# Make text bigger
		var extra_size = 20 * t  # up to +20 px
		countdown_label.add_theme_font_size_override("font_size", base_size + extra_size)
	else:
		# Reset to normal if not in last 5 seconds
		countdown_label.add_theme_color_override("font_color", Color.WHITE)
		countdown_label.add_theme_font_size_override("font_size", base_size)


func _on_survival_timer_timeout() -> void:
	Game.level_complete()
