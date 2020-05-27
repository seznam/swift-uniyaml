// swift-tools-version:5.2

import PackageDescription

let package = Package(
	name: "UniYAML",
	products: [
		.library(name: "UniYAML", targets: ["UniYAML"])
	],
	targets: [
		.target(name: "UniYAML"),
		.testTarget(name: "UniYAMLTests", dependencies: ["UniYAML"])
	],
	swiftLanguageVersions: [.v4, .v4_2, .v5]
)
