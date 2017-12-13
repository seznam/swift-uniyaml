import Foundation

public enum YAMLType: String {
	case pending
	case empty
	case string
	case integer
	case double
	case array
	case dictionary
}

public struct YAML {
	let indent: Int
	var type: YAMLType
	let key: String?
	let tag: String?
	var value: Any?
	public var count: Int? {
		if type == .array, let array = value as? [YAML] {
			return array.count
		} else if type == .dictionary, let dictionary = value as? [String: YAML] {
			return dictionary.keys.count
		}
		return nil
	}
	public var keys: [String]? {
		if type == .dictionary, let dictionary = value as? [String: YAML] {
			return dictionary.keys.map { member in return member }
		}
		return nil
	}
	public var string: String? {
		return (type == .string) ? (value as? String):nil
	}
	public var int: Int? {
		if type == .integer, let i = value as? Int {
			return i
		} else if type == .string, let i = value as? String {
			return Int(i)
		}
		return nil
	}
	public var uint: UInt? {
		if type == .integer, let i = value as? Int {
			return UInt(i)
		} else if type == .string, let i = value as? String, let u = UInt(i) {
			return u
		}
		return nil
	}
	public var double: Double? {
		if type == .double, let d = value as? Double {
			return d
		} else if type == .string, let i = value as? String {
			return Double(i)
		}
		return nil
	}
	public var bool: Bool? {
		var s: String
		if type == .string {
			s = value as! String
		} else if type == .integer {
			s = "\(value as! Int)"
		} else {
			return nil
		}
		switch s.lowercased() {
		case "0", "off", "false", "no":
			return false
		case "1", "on", "true", "yes":
			return true
		default:
			return nil
		}
	}
	public var array: [YAML]? {
		return (type == .array) ? (value as? [YAML]):nil
	}
	public var dictionary: [String: YAML]? {
		return (type == .dictionary) ? (value as? [String: YAML]):nil
	}
	public var first: YAML? {
		guard type == .array, let array = value as? [YAML] else {
			return nil
		}
		return array.first
	}
	public var last: YAML? {
		guard type == .array, let array = value as? [YAML] else {
			return nil
		}
		return array.last
	}
	public subscript(index: Int) -> YAML? {
		guard type == .array, let array = value as? [YAML] else {
			return nil
		}
		return array[index]
	}
	public subscript(key: String) -> YAML? {
		guard type == .dictionary, let dictionary = value as? [String: YAML] else {
			return nil
		}
		return dictionary[key]
	}
}
