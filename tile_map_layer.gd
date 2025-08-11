extends TileMapLayer
func _ready():
	hide()
	
func _on_hud_start_game() -> void:
	show()
