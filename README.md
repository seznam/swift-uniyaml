![](https://img.shields.io/badge/Swift-5.2-orange.svg?style=flat)
![macOS](https://img.shields.io/badge/os-macOS-green.svg?style=flat)
![Linux](https://img.shields.io/badge/os-linux-green.svg?style=flat)
![Apache 2](https://img.shields.io/badge/license-Apache2-blue.svg?style=flat)
![Build Status](https://travis-ci.com/seznam/swift-uniyaml.svg?branch=master)

# UniYAML

Na(t)ive YAML/JSON (de)serializer for Swift. It started with a naive question "how hard it can be to write YAML parser?", followed by a naive answer "it can't be that hard". ;-) It's not a complete YAML 1.[012] implementation yet, but it proved to be usable for reading and writing basic YAML/JSON structures at decent speed.

## Usage

Parse YAML or JSON and access data directly:

```swift
import UniYAML

let json = """
{ 
  \"first name\": Antonio, 
  \"middle name\": Lucio, 
  surname: Vivaldi, 
  nickname: 'il Prete Rosso', 
  born: 1678
}
"""

do {

	let obj = try UniYAML.decode(json)

	print("person details available: \(obj.keys)")
	print("\(obj["first name"]?.string) \(obj["surname"]?.string) aka \(obj["nickname"]?.string) was born on \(obj["born"]?.uint)")

} catch UniYAMLError.error(let detail) {
	print(detail)
}
```

```swift
import UniYAML

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

do {
	let obj = try UniYAML.decode(yaml)

	let collection = obj["classic"]!.array!

	print("there are \(collection.count) entries in 'classic' collection")

	let first = collection[0].dictionary!
	let last = collection.last!.dictionary!

	print("shortest (\(first["duration"]?.string)) is \(first["title"]?.string) from \(first["author"]?.string)")
	print("longest (\(last["duration"]?.string)) is \(last["title"]?.string) from \(last["author"]?.string)")

} catch UniYAMLError.error(let detail) {
	print(detail)
}
```

Easily convert parsed content to expected types:

```swift
import UniYAML

let types = """
---
no choice: don't say anything
variants: 'say ''yes'' or ''no'''
split string: >
  two
  words
rows: |
   first
   second
   last
int: -12345
uint: 67890
double: 3.14159265
positive: yes
negative: off
"""

do {

	let obj = try UniYAML.decode(types)

	print("string: '\(obj["variants"]?.string)'")
	print("multi-line string: '\(obj["rows"]?.string)'")
	print("integer: \(obj["int"]?.int)")
	print("unsigned integer: \(obj["uint"]?.uint)")
	print("double: \(obj["double"]?.double)")
	print("bool: \(obj["negative"]?.bool)")

} catch UniYAMLError.error(let detail) {
	print(detail)
}
```

Serialize custom data structures:

```swift
import UniYAML

do {

	let obj1 = YAML([1, 2, "A", "B"])!
	let json = try UniYAML.encode(obj1)

	let obj2 = YAML(["key": "value", "int": -987, "double": -543.21])!
	let yaml = try UniYAML.encode(obj2, with: .yaml)

	let obj3 = YAML(["key": "value", "array": YAML([10, 11, 12])!, "dict": YAML(["number": 1, "text": "test", "double": 12.34])!])!
	let complex = try UniYAML.encode(obj3)

} catch UniYAMLError.error(let detail) {
	print(detail)
}
```

## Credits

Written by [Daniel Fojt](https://github.com/danielfojt/), copyright [Seznam.cz](https://onas.seznam.cz/en/), licensed under the terms of the Apache License 2.0.
