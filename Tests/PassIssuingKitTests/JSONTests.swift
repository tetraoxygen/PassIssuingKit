import XCTest
@testable import PassIssuingKit

extension PassIssuingKitTests {
	static let passProperties = Pass.Properties(
		passTypeIdentifier: "pass.com.hackclub.event.summer.2022",
		serialNumber: "670DD3E7-7AA6-48B3-A04B-6B91E569EF4E",
		teamIdentifier: "P6PV2R9443",
		webServiceURL: URL(string: "https://api.ticketing.assemble.hackclub.com/tickets/update/")!,
		authenticationToken: "eyJhafdsadfjfjkd",
		foregroundColor: .init(hex: "ffffff"),
		backgroundColor: .init(hex: "C0362C"),
		labelColor: .init(hex: "ffffff"),
		barcodes: [.init(message: "ASSEMBLEWOOT", format: .qr)], logoText: "Assemble",
		organizationName: "The Hack Foundation",
		description: "Hack Club Assemble Ticket",
		style: .eventTicket(
			body: .init(
				primaryFields: [
					.generic(.init(key: "name", value: "Charlie Welsh")),
					.currency(.init(key: "price", value: 1.00, currencyCode: "USD"))
				],
				secondaryFields: [
					.generic(.init(key: "loc", value: "Figma HQ", label: "LOCATION")),
					.date(
						.init(
							key: "time",
							value: "2022-08-05T18:00:00-07:00",
							label: "DATE",
							dateStyle: .medium,
							timeStyle: .medium,
							isRelative: true
						)
					)
				]
			)
		)
	)

	// MARK: - Properties

	func testPropertiesEncode() throws {
		let encoder = JSONEncoder()
		encoder.dateEncodingStrategy = .iso8601

		let encoded = try encoder.encode(Self.passProperties)

		let exampleLocation = signingConfig.resourceLocation.appendingPathComponent("pass.json")
		let exampleData = try Data(contentsOf: exampleLocation)

		XCTAssertEqual(encoded, exampleData)
	}


	func testPropertiesDecode() throws {
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601

		let exampleLocation = signingConfig.resourceLocation.appendingPathComponent("pass.json")
		let exampleData = try Data(contentsOf: exampleLocation)

		let decoded = try decoder.decode(Pass.Properties.self, from: exampleData)

		XCTAssertEqual(decoded, Self.passProperties)
	}

	func testPropertiesRoundtrip() throws {
		let encoder = JSONEncoder()
		encoder.dateEncodingStrategy = .iso8601

		let encoded = try encoder.encode(Self.passProperties)

		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601

		let decoded = try decoder.decode(Pass.Properties.self, from: encoded)

		XCTAssertEqual(decoded, Self.passProperties)
	}

	// MARK: - TypedField
	func testTypedFieldRoundtrip() throws {
		let encoder = JSONEncoder()
		encoder.dateEncodingStrategy = .iso8601

		let formatting = Self.passProperties.style.body.secondaryFields!.last!

		let encoded = try encoder.encode(formatting)

		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601

		let decoded = try decoder.decode(Pass.TypedField.self, from: encoded)

		XCTAssertEqual(decoded, formatting)
	}
}

