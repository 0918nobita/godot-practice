# FIXME: Use typed enum (GDScript 2.0)
# https://godotengine.org/article/gdscript-progress-report-type-checking-back
class DirectionDU:
	var _id : int
	func _init(id : int):
		_id = id
	func equals(other : DirectionDU) -> bool:
		return _id == other._id


static func left() -> DirectionDU:
	return DirectionDU.new(0)


static func right() -> DirectionDU:
	return DirectionDU.new(1)
