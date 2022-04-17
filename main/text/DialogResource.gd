extends Resource
class_name DialogResource


const Msgs := preload("res://main/text/Messages.gd")


export (Array, String) var dialog : Array


func load_as_message_array() -> Msgs.MessageArray:
	var msgs = Msgs.MessageArray.new()
	for msg in dialog:
		if msg is String:
			msgs.push_back(Msgs.Message.new(msg))
		else:
			push_error("Invalid dialog data")
	return msgs
