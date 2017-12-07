import Foundation

public enum UniYAMLNotation: String {
	case json, yaml
}

extension UniYAML {

	private struct Key {
		let id: String
		init(_ id: String) {
			self.id = id
		}
	}

	private struct Closure {
		let mark: String
		init(_ mark: String) {
			self.mark = mark
		}
	}

	static private func escape(_ input: String) -> String {
		return input.replacingOccurrences(of: "\\", with: "\\\\").replacingOccurrences(of: "\"", with: "\\\"").replacingOccurrences(of: "\t", with: "\\t").replacingOccurrences(of: "\n", with: "\\n").replacingOccurrences(of: "\r", with: "\\r")
	}

	static public func encode(_ object: Any, with notation: UniYAMLNotation = .json) throws -> String {
		guard notation == .json else {
			throw UniYAMLError.error(detail: "\(notation) encoder not yet implemented")
		}
		var stack = [Any]()
		stack.append(object)
		var stream = ""
		while stack.count > 0 {
			let current = stack.remove(at: 0)
			if let obj = current as? Key {
				stream += "\"\(UniYAML.escape(obj.id))\":"
			} else if let obj = current as? String {
				stream += "\"\(UniYAML.escape(obj))\","
			} else if let obj = current as? Int {
				stream += "\(obj),"
			} else if let obj = current as? Double {
				stream += "\(obj),"
			} else if let obj = current as? [Any] {
				stream += "["
				var i = 0
				for v in obj {
					stack.insert(v, at: i)
					i += 1
				}
				stack.insert(Closure("]"), at: i)
			} else if let obj = current as? [String: Any] {
				stream += "{"
				var i = 0
				for (k, v) in obj {
					let kk = Key(k)
					stack.insert(kk, at: i)
					stack.insert(v, at: i + 1)
					i += 2
				}
				stack.insert(Closure("}"), at: i)
			} else if let obj = current as? Closure {
				if stream.hasSuffix(",") {
					_ = stream.remove(at: stream.index(stream.endIndex, offsetBy: -1))
				}
				stream += "\(obj.mark),"
			} else if let obj = current as? YAML {
				if obj.type == .string, let o = obj.value as? String {
					stream += "\"\(UniYAML.escape(o))\","
				} else if obj.type == .integer, let o = obj.value as? Int {
					stream += "\(o),"
				} else if obj.type == .double, let o = obj.value as? Double {
					stream += "\(o),"
				} else if obj.type == .array, let o = obj.value as? [YAML] {
					stream += "["
					var i = 0
					for v in o {
						stack.insert(v, at: i)
						i += 1
					}
					stack.insert(Closure("]"), at: i)
				} else if obj.type == .dictionary, let o = obj.value as? [String: YAML] {
					stream += "{"
					var i = 0
					for (k, v) in o {
						let kk = Key(k)
						stack.insert(kk, at: i)
						stack.insert(v, at: i + 1)
						i += 2
					}
					stack.insert(Closure("}"), at: i)
				} else {
					throw UniYAMLError.error(detail: "unsupported type")
				}
			} else {
				throw UniYAMLError.error(detail: "unsupported type")
			}
		}
		if stream.hasSuffix(",") {
			_ = stream.remove(at: stream.index(stream.endIndex, offsetBy: -1))
		}
		return stream
	}

}
