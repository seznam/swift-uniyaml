// swift-tools-version:4.0

import PackageDescription

let package = Package(
	name: "UniYAML",
	products: [
		.library(name: "UniYAML", targets: ["UniYAML"])
	],
	targets: [
		.target(name: "UniYAML")
	]
)
