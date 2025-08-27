extends Node
enum MenuType{
	
}
enum OverlayType{
	
}
var menus: Dictionary[MenuType, Control] = {}
var overlays: Dictionary[OverlayType, Control] = {}
var active_overlays: Array[Control] = []
var active_menu: Control = null

func set_up_ui(canvas_layer: CanvasLayer) -> void:
	print(canvas_layer == null)
	
func swap_menu_to(menu_type: MenuType) -> void:
	if active_menu:
		active_menu.visible = false
	active_menu = menus[menu_type]
	active_menu.visible = true
	
	
func activate_overlay(overlay_type: OverlayType) -> void:
	overlays[overlay_type].visible = true
	active_overlays.append(overlays[overlay_type])
	
	
func deactivate_overlay(overlay_type: OverlayType) -> void:
	overlays[overlay_type].visible = false
	active_overlays.erase(overlays[overlay_type])
