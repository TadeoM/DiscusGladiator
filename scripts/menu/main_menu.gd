extends Control

signal start_game()
@onready var buttons_v_box = %ButtonsVBox
@onready var multiButtons = %MultiButtonsVBox
@onready var pongButtons = %PongVBox
@onready var pingButtons = %PingVBox

func _on_start_game_pressed() -> void:
	start_game.emit()
	hide()

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_visibility_changed() -> void:
	if visible:
		focus_button()
	
func focus_button() -> void:
	if buttons_v_box:
		var button : Button = buttons_v_box.get_child(0)
		if button is Button:
			button.grab_focus()


func _on_multiplayer_pressed() -> void:
	multiButtons.visible = true
	buttons_v_box.visible = false


func _on_server_button_pressed() -> void:
	pongButtons.visible = true
	multiButtons.visible = false

func _on_client_button_pressed() -> void:
	pingButtons.visible = true
	multiButtons.visible = false


func _on_back_button_pressed() -> void:
	buttons_v_box.visible = true
	multiButtons.visible = false
	pongButtons.visible = false
	pingButtons.visible = false
