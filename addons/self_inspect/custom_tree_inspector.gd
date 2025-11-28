@tool
extends Tree


func set_all_visible(item: TreeItem) -> void:
	if not item:
		return
	item.visible = true
	set_all_visible(item.get_parent())

func build_tree(node: Node, parent_item: TreeItem) -> void:
	
	if not parent_item:
		parent_item = create_item()
		parent_item.collapsed = false
	else:
		parent_item.collapsed = true
	
	#if node.get_class().contains("Tree"):
		#print("Parent node is tree")
		#set_all_visible(parent_item)
	#else:
		#print("Parent node isn't tree")
		#parent_item.visible = false
	
	var node_name: String = node.name.trim_prefix("@").get_slice("@", 0)
	var node_icon: Texture2D = EditorInterface.get_base_control().get_theme_icon(node.get_class(), "EditorIcons")
	
	#var found_classes: Array
	#for global_class: Dictionary in ProjectSettings.get_global_class_list():
		#var c = global_class["class"]
		#if found_classes.has(c):
			#continue
		#else:
			#found_classes.append(c)
		#
		#print("\n\nClass: ",c,"\t\t",type_string(global_class["class"]))
		#print("Icon: ",global_class["icon"],"\t\t",type_string(global_class["icon"]))
		#if c == node_class:
			#print(global_class["icon"])
			#print("FOUND IT")
			#node_icon = global_class["icon"]
			#break
	#print(found_classes)
	
	parent_item.set_text(0, node_name)
	parent_item.set_icon(0, node_icon)
	parent_item.set_metadata(0, node)
	for child in node.get_children():
		var child_item = create_item(parent_item)
		build_tree(child, child_item)

func _on_reload() -> void:
	var root = get_tree().root
	clear()
	build_tree(root, null)


func _on_item_selected() -> void:
	var tree_item = get_selected()
	var node = tree_item.get_metadata(0)
	EditorInterface.inspect_object(node)
