import XCTest
@testable import PassIssuingKit

final class PassIssuingKitTests: XCTestCase {
    func testSigning() throws {
		let signingConfig = try SigningConfiguration()

		Pass.setWWDRCert(at: signingConfig.wwdrCertLocation)

		let directoryPaths = try FileManager.default.contentsOfDirectory(atPath: signingConfig.resourceLocation.path)

		let resourceLocations = directoryPaths.map { path in
			signingConfig.resourceLocation.appendingPathComponent(path)
		}

		let pass = Pass(
			properties: Self.passProperties,
			resources: resourceLocations
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
		var resourceLocation: URL
		/// The location to output the pass to. Should be a file ending in .pkpass.
		var outputLocation: URL

		init() throws {
			self.password = try Environment.get(key: "TEST_SIGNING_PASSWORD")
			self.signingCertLocation = try Environment.get(key: "TEST_SIGNING_CERT")
			self.wwdrCertLocation = try Environment.get(key: "TEST_WWDR_CERT")
			self.resourceLocation = try Environment.get(key: "TEST_RESOURCES")
			self.outputLocation = try Environment.get(key: "TEST_OUTPUT")
		}
	}
}
