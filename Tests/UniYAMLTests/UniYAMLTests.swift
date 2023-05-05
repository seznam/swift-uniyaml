import XCTest

@testable import UniYAML

class UniYAMLTests: XCTestCase {

	static var allTests = [
		("testYAMLSimpleString", testYAMLSimpleString),
		("testYAMLQuotedString", testYAMLQuotedString),
		("testYAMLSplitString", testYAMLSplitString),
		("testYAMLRowsString", testYAMLRowsString),
		("testYAMLInt", testYAMLInt),
		("testYAMLUInt", testYAMLUInt),
		("testYAMLDouble", testYAMLDouble),
		("testYAMLBoolPos", testYAMLBoolPos),
		("testYAMLBoolNeg", testYAMLBoolNeg),
		("testJSONArrayDecode", testJSONArrayDecode),
		("testYAMLArrayDecode", testYAMLArrayDecode),
		("testJSONDictDecode", testJSONDictDecode),
		("testYAMLDictDecode", testYAMLDictDecode),
		("testYAMLDictArrayDictsDecode", testYAMLDictArrayDictsDecode),
		("testJSONComplexDecode", testJSONComplexDecode),
		("testYAMLComplexDecode", testYAMLComplexDecode),
		("testJSONArrayEncode", testJSONArrayEncode),
		("testYAMLArrayEncode", testYAMLArrayEncode),
		("testJSONDictEncode", testJSONDictEncode),
		("testYAMLDictEncode", testYAMLDictEncode),
		("testJSONComplexEncode", testJSONComplexEncode),
		("testYAMLComplexEncode", testYAMLComplexEncode),
		("testYAMLBadIndent", testYAMLBadIndent),
		("testYAMLUnexpectedValue", testYAMLUnexpectedValue),
		("testYAMLUnexpectedColon", testYAMLUnexpectedColon),
		("testYAMLUnexpectedBrace", testYAMLUnexpectedBrace),
		("testYAMLUnexpectedEnd", testYAMLUnexpectedEnd),
		("testPartialYAML", testPartialYAML),
		("testPartialYAML2", testPartialYAML2),
		("testPartialYAML3", testPartialYAML3),
	]

	let types = "---\n\nsimple string: a text\nquoted string: 'john ''beatle''\n lennon'\nsplit string: >\n  two\n  words\nrows: |\n  first\n  second\n  last\nint: -12345\nuint: 67890\ndouble: 3.14159265\npositive: yes\nnegative: off\n"

	func testYAMLSimpleString() {
		//print(types)
		var obj: YAML?
		do {
			obj = try UniYAML.decode(types)
		} catch {
			print(error)
			obj = nil
		}
		XCTAssert(obj != nil &&
			obj!["simple string"]?.string == "a text"
		)
	}

	func testYAMLQuotedString() {
		var obj: YAML?
		do {
			obj = try UniYAML.decode(types)
		} catch {
			print(error)
			obj = nil
		}
		XCTAssert(obj != nil &&
			obj!["quoted string"]?.string == "john 'beatle' lennon"
		)
	}
	func testYAMLSplitString() {
		var obj: YAML?
		do {
			obj = try UniYAML.decode(types)
		} catch {
			print(error)
			obj = nil
		}
		XCTAssert(obj != nil &&
			obj!["split string"]?.string == "two words"
		)
	}

	func testYAMLRowsString() {
		var obj: YAML?
		do {
			obj = try UniYAML.decode(types)
		} catch {
			print(error)
			obj = nil
		}
		XCTAssert(obj != nil &&
			obj!["rows"]?.string == "first\nsecond\nlast"
		)
	}

	func testYAMLInt() {
		var obj: YAML?
		do {
			obj = try UniYAML.decode(types)
		} catch {
			print(error)
			obj = nil
		}
		XCTAssert(obj != nil &&
			obj!["int"]?.int == -12345
		)
	}

	func testYAMLUInt() {
		var obj: YAML?
		do {
			obj = try UniYAML.decode(types)
		} catch {
			print(error)
			obj = nil
		}
		XCTAssert(obj != nil &&
			obj!["uint"]?.uint == 67890
		)
	}

	func testYAMLDouble() {
		var obj: YAML?
		do {
			obj = try UniYAML.decode(types)
		} catch {
			print(error)
			obj = nil
		}
		XCTAssert(obj != nil &&
			obj!["double"]?.double == 3.14159265
		)
	}

	func testYAMLBoolPos() {
		var obj: YAML?
		do {
			obj = try UniYAML.decode(types)
		} catch {
			print(error)
			obj = nil
		}
		XCTAssert(obj != nil &&
			obj!["positive"]?.bool == true
		)
	}

	func testYAMLBoolNeg() {
		var obj: YAML?
		do {
			obj = try UniYAML.decode(types)
		} catch {
			print(error)
			obj = nil
		}
		XCTAssert(obj != nil &&
			obj!["negative"]?.bool == false
		)
	}

	func testJSONArrayDecode() {
		let json = "[ 'first', 'second', 'third', 'fourth' ]"
		//print(json)
		var obj: YAML?
		do {
			obj = try UniYAML.decode(json)
		} catch {
			print(error)
			obj = nil
		}
		XCTAssert(obj != nil &&
			obj!.type == .array &&
			obj!.first?.string == "first" &&
			obj![1]?.string == "second" &&
			obj!.last?.string == "fourth"
		)
	}

	func testYAMLArrayDecode() {
		let yaml = "---\n\n- 1\n- -2\n- 3\n- 4.567\n"
		//print(yaml)
		var obj: YAML?
		do {
			obj = try UniYAML.decode(yaml)
		} catch {
			print(error)
			obj = nil
		}
		XCTAssert(obj != nil &&
			obj!.type == .array &&
			obj!.first?.uint == 1 &&
			obj![1]?.int == -2 &&
			obj!.last?.double == 4.567
		)
	}

	func testJSONDictDecode() {
		let json = "{ author: \"W.A.Mozart\", title: \"Eine kleine Nachtmusik\", year: 1787, duration: \"5:45\" }"
		//print(json)
		var obj: YAML?
		do {
			obj = try UniYAML.decode(json)
		} catch {
			print(error)
			obj = nil
		}
		XCTAssert(obj != nil &&
			obj!.type == .dictionary &&
			obj!.keys!.count == 4 &&
			obj!["author"]?.string == "W.A.Mozart" &&
			obj!["year"]?.int == 1787 &&
			obj!["title"]!.string!.hasSuffix("musik") &&
			obj!["duration"]!.string!.contains(":")
		)
	}

	func testYAMLDictDecode() {
		let yaml = "---\nfirst name: Antonio\nmiddle name: Lucio\nsurname: Vivaldi\nnickname: il Prete Rosso\ndate of birth: 4.3.1678\n"
		//print(yaml)
		var obj: YAML?
		do {
			obj = try UniYAML.decode(yaml)
		} catch {
			print(error)
			obj = nil
		}
		XCTAssert(obj != nil &&
			obj!.type == .dictionary &&
			obj!.keys!.count == 5 &&
			obj!["first name"]!.string! == "Antonio" &&
			obj!["surname"]!.string! == "Vivaldi" &&
			obj!["nickname"]!.string!.hasSuffix("Rosso") &&
			obj!["date of birth"]!.string!.hasPrefix("4.3.")
		)
	}

	func testYAMLDictArrayDictsDecode() {
		let yaml = """
---

classic:
  -
    author: Ludwig van Beethoven
    title: Für Elise
    published: 1867
    duration: 3:30
  -
    author: Wolfgang Amdeus Mozart
    title: Eine kleine Nachtmusik
    published: 1787
    duration: 5:45
  -
    author: Bedřich Smetana
    title: Vltava
    published: 1874
    duration: 12:50
"""
		//print(yaml)
		var obj: YAML?
		do {
			obj = try UniYAML.decode(yaml)
		} catch {
			print(error)
			obj = nil
		}
		let array = obj?["classic"]?.array
		let dict = array?.last?.dictionary
		XCTAssert(dict != nil &&
			dict!.keys.count == 4 &&
			dict!["author"]!.string! == "Bedřich Smetana" &&
			dict!["published"]!.int! == 1874
		)
	}

	func testJSONComplexDecode() {
		let json = "{\n\"id\":\"devops\",\n\"type\":\"group\",\n\"name\":\"Senior DevOps\",\n\"channel\":{\"email\":\"devops@bnl.com\",\"irc\":\"devops#irc.bnl.com\"},\n\"members\":[\"peter.sun\",\"mary.moon\",\"john.star\"]\n}"
		//print(json)
		var obj: YAML?
		do {
			obj = try UniYAML.decode(json)
		} catch {
			print(error)
			obj = nil
		}
		XCTAssert(obj != nil &&
			obj!.type == .dictionary &&
			obj!.keys!.count == 5 &&
			obj!["id"]!.string! == "devops" &&
			obj!["channel"]?.type == .dictionary &&
			obj!["channel"]?["email"]!.string! == "devops@bnl.com" &&
			obj!["members"]?.array?.first?.string == "peter.sun"
		)
	}

	func testYAMLComplexDecode() {
		let yaml = "dict:\n  key1:\n    folded key: >\n      A1B\n      2C\n      D3\n    2-line key: |\n     first line\n     second line\n    sub dict:\n     k1: 1\n     k2: 2\n    sub array:\n    - member 1\n    - member 2\n    - member 3\n  integer: 341002\n  array of dicts:\n   -\n     key1: k1\n   -\n     key2: k2\n  double:49.53\n\narray of arrays:\n  -\n    - 0\n    - 1\n    - 2\n  - second\n  -\n    third: last\n"
		//print(yaml)
		var obj: YAML?
		do {
			obj = try UniYAML.decode(yaml)
		} catch {
			print(error)
			obj = nil
		}
		XCTAssert(obj != nil &&
			obj!.type == .dictionary &&
			obj!.keys!.count == 2 &&
			obj!["dict"]?.type == .dictionary &&
			obj!["dict"]?["integer"]?.int == 341002 &&
			obj!["dict"]?["double"]?.double == 49.53 &&
			obj!["dict"]?["key1"]?["folded key"]?.string == "A1B 2C D3" &&
			obj!["dict"]?["key1"]?["2-line key"]?.string == "first line\nsecond line" &&
			obj!["dict"]?["key1"]?["sub array"]?.count == 3 &&
			obj!["array of arrays"]?.type == .array &&
			obj!["array of arrays"]?[1]?.string == "second" &&
			obj!["array of arrays"]?.last?.type == .dictionary
		)
	}

	func testJSONArrayEncode() {
		let obj = YAML([1, 2, "A", "B"])!
		let string = try? UniYAML.encode(obj)
		//print(string)
		XCTAssert(string != nil &&
			string == "[1,2,\"A\",\"B\"]"
		)
	}

	func testYAMLArrayEncode() {
		let obj = YAML([11.22, "+", -3344, "-"])!
		let string = try? UniYAML.encode(obj, with: .yaml)
		XCTAssert(string != nil &&
			string == "- 11.22\n- +\n- -3344\n- \"-\"\n"
		)
	}

	func testJSONDictEncode() {
		let obj = YAML(["string key": "string value", "int key": -987, "double key": -543.21])!
		let string = try? UniYAML.encode(obj)
		//print(string)
		XCTAssert(string != nil &&
			string!.hasPrefix("{") &&
			string!.hasSuffix("}") &&
			string!.contains("\"string key\":\"string value\"") &&
			string!.contains("\"int key\":-987") &&
			string!.contains("\"double key\":-543.21")
		)
	}

	func testYAMLDictEncode() {
		let obj = YAML(["string key": "string value", "int key": -987, "double key": -543.21])!
		let string = try? UniYAML.encode(obj, with: .yaml)
		//print(string)
		XCTAssert(string != nil &&
			string!.contains("\"string key\": string value\n") &&
			string!.contains("\"int key\": -987\n") &&
			string!.contains("\"double key\": -543.21\n")
		)
	}

	func testJSONComplexEncode() {
		let obj = YAML(["key": "value", "array": YAML([10, 11, 12])!, "dict": YAML(["number": 1, "text": "test", "double": 12.34])!])!
		let string = try? UniYAML.encode(obj)
		//print(string)
		XCTAssert(string != nil &&
			string!.contains("\"key\":\"value\"") &&
			string!.contains("\"dict\":{") &&
			string!.contains("\"text\":\"test\"") &&
			string!.contains("\"number\":1") &&
			string!.contains("\"double\":12.34") &&
			string!.contains("\"array\":[10,11,12]")
		)
	}

	func testYAMLComplexEncode() {
		let obj = YAML(["key": "value", "array": YAML([10, 11, 12])!, "dict": YAML(["number": 1, "text": "test", "double": 12.34])!])!
		let string = try? UniYAML.encode(obj, with: .yaml)
		//print(string)
		XCTAssert(string != nil &&
			string!.contains("key: value\n") &&
			string!.contains("dict: \n") &&
			string!.contains("  text: test\n") &&
			string!.contains("  number: 1\n") &&
			string!.contains("  double: 12.34\n") &&
			string!.contains("array: \n  - 10\n  - 11\n  - 12\n")
		)
	}

	func testYAMLBadIndent() {
		let yaml = "top:\n  sub1: 1\n sub2: 2\n"
		//print(yaml)
		var obj: YAML?
		var err: String = ""
		do {
			obj = try UniYAML.decode(yaml)
		} catch UniYAMLError.error(let detail) {
			err = detail
		} catch {
			print(error)
		}
		XCTAssert(obj == nil && err.hasPrefix("indentation mismatch"))
	}

	func testYAMLUnexpectedValue() {
		let yaml = "set:\n - one\n - two\n three\n"
		//print(yaml)
		var obj: YAML?
		var err: String = ""
		do {
			obj = try UniYAML.decode(yaml)
		} catch UniYAMLError.error(let detail) {
			err = detail
		} catch {
			print(error)
		}
		XCTAssert(obj == nil && err.hasPrefix("unexpected value"))
	}

	func testYAMLUnexpectedColon() {
		let yaml = "set:\n : one\n key: value\n"
		//print(yaml)
		var obj: YAML?
		var err: String = ""
		do {
			obj = try UniYAML.decode(yaml)
		} catch UniYAMLError.error(let detail) {
			err = detail
		} catch {
			print(error)
		}
		XCTAssert(obj == nil && err.hasPrefix("unexpected colon"))
	}

	func testYAMLUnexpectedBrace() {
		let yaml = "set: { key: value ]}\n"
		//print(yaml)
		var obj: YAML?
		var err: String = ""
		do {
			obj = try UniYAML.decode(yaml)
		} catch UniYAMLError.error(let detail) {
			err = detail
		} catch {
			print(error)
		}
		XCTAssert(obj == nil && err.hasPrefix("unexpected closing brace"))
	}

	func testYAMLUnexpectedEnd() {
		let yaml = "set: [\n1,\n2,\n3\n"
		//print(yaml)
		var obj: YAML?
		var err: String = ""
		do {
			obj = try UniYAML.decode(yaml)
		} catch UniYAMLError.error(let detail) {
			err = detail
		} catch {
			print(error)
		}
		XCTAssert(obj == nil && err.hasPrefix("unexpected stream end"))
	}

	func testPartialYAML() throws {
		let yaml = "a: "
		let obj = try UniYAML.decode(yaml)
		XCTAssert(
			obj.type == .dictionary &&
			obj.keys!.count == 1 &&
			obj["a"]?.type == .pending
		)
	}

	func testPartialYAML2() {
		let yaml = "a: 3\n "
		var obj: YAML?
		var err: String = ""
		do {
			obj = try UniYAML.decode(yaml)
		} catch UniYAMLError.error(let detail) {
			err = detail
		} catch {
			print(error)
		}
		XCTAssert(obj == nil && err.hasPrefix("missing value at line 2"))
	}

	func testPartialYAML3() {
		let yaml = "a: 3\n  b"
		var obj: YAML?
		var err: String = ""
		do {
			obj = try UniYAML.decode(yaml)
		} catch UniYAMLError.error(let detail) {
			err = detail
		} catch {
			print(error)
		}
		XCTAssert(obj == nil && err.hasPrefix("missing value at line 2"))
	}

}
