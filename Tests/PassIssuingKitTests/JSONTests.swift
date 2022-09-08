import Foundation
@testable import PassIssuingKit

extension PassIssuingKitTests {
	static let minifiedJSON = try! String(
		contentsOf: URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("Resources/pass.json")
	)

	static let passProperties = Pass.Properties(
		passTypeIdentifier: "pass.com.hackclub.event.summer.2022",
		serialNumber: "670DD3E7-7AA6-48B3-A04B-6B91E569EF4E",
		teamIdentifier: "P6PV2R9443",
		webServiceURL: URL(string: "https://api.ticketing.assemble.hackclub.com/tickets/update/")!,
		authenticationToken: "eyJhafdsadfjfjkd",
		foregroundColor: .init(hex: "ffffff"),
		backgroundColor: .init(hex: "C0362C"),
		labelColor: .init(hex: "ffffff"),
		barcodes: [.init(message: "eyJh", format: .qr)], logoText: "Assemble",
		organizationName: "The Hackasfdjkl Foundation",
		description: "Hack Club Assemble Ticket",
		style: .eventTicket(
			body: .init(
				primaryFields: [.init(key: "name", value: "Charlie Welsh")],
				secondaryFields: [
					.init(key: "loc", value: "Figma HQ", label: "LOCATION"),
					.init(
						key: "time",
						value: "2022-08-05T18:00:00-07:00",
						label: "DATE",
						formatting: .dateStyle(
							options: .init(
								dateStyle: .medium,
								timeStyle: .medium,
								isRelative: true
							)
						)
					)
				]
			)
		)
	)


//	func testPropertiesEncode() throws {
//		let encoder = JSONEncoder()
//		encoder.dateEncodingStrategy = .iso8601
//		encoder.encoding
//	}
}
