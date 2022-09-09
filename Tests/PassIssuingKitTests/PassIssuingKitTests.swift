import XCTest
@testable import PassIssuingKit

final class PassIssuingKitTests: XCTestCase {
	let signingConfig = try! SigningConfiguration()

    func testSigning() throws {
		Pass.setWWDRCert(at: signingConfig.wwdrCertLocation)

		let imageDirectory = signingConfig.resourceLocation.appendingPathComponent("Images")

		let imagePaths = try FileManager.default.contentsOfDirectory(atPath: imageDirectory.path)

		let imageLocations = imagePaths.map { path in
			imageDirectory.appendingPathComponent(path)
		}

		let pass = Pass(
			properties: Self.passProperties,
			images: imageLocations
		)

		let encoded = try pass.issue(using: signingConfig.signingCertLocation, password: signingConfig.password)

		FileManager.default.createFile(atPath: signingConfig.outputLocation.path, contents: encoded)
    }

	/// The necessary configuration to sign a Wallet pass.
	struct SigningConfiguration {
		/// The password to the signing cert.
		var password: String
		/// The location of the signing cert.
		var signingCertLocation: URL
		/// The location of the WWDR cert.
		var wwdrCertLocation: URL
		/// The location of the directory containing all the pass's resources.
		var resourceLocation: URL {
			let fileURL = URL(fileURLWithPath: #file)
			let testDir = fileURL.deletingLastPathComponent()
			
			return testDir.appendingPathComponent("Resources")
		}
		/// The location to output the pass to. Should be a file ending in .pkpass.
		var outputLocation: URL

		init() throws {
			self.password = try Environment.get(key: "TEST_SIGNING_PASSWORD")
			self.signingCertLocation = try Environment.get(key: "TEST_SIGNING_CERT")
			self.wwdrCertLocation = try Environment.get(key: "TEST_WWDR_CERT")
			self.outputLocation = try Environment.get(key: "TEST_OUTPUT")
		}
	}
}
