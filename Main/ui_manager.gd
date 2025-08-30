extends Node
enum MenuType{
	SHOP
}
enum OverlayType{
	
}
const SHOP_UID: String = "uid://blae5ddggtsn5"

var shop_scene: Control = preload(SHOP_UID).instantiate()


var menus: Dictionary[MenuType, Control] = {
	MenuType.SHOP: shop_scene
}

var overlays: Dictionary[OverlayType, Control] = {}
var active_overlays: Array[Control] = []
var active_menu: Control = null
var ui_instantiated: bool = false
	
	
func set_up_ui(canvas_layer: CanvasLayer) -> void:
	if ui_instantiated:
		push_error("UI already initialized")
	_set_up_menus(canvas_layer)
	_set_up_overlays()
	
	
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
	
	
func _set_up_menus(canvas_layer: CanvasLayer) -> void:
	for menu in menus.values():
		if menu:
			canvas_layer.add_child(menu)
		else:
			push_error(menu.name + " is not valid")
	
func _set_up_overlays() -> void:
	pass
