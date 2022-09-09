import Foundation
import PassEncoder

public extension Pass {
	/// Sets the location of the WWDR cert for pass signing.
	static func setWWDRCert(at url: URL) {
		PassSigner.shared.appleWWDRCertURL = url
	}

	/// Issues a Wallet pass. Make sure to call `setWWDRCert` first or this fatalErrors.
	/// - Parameters:
	///   - passCertURL: The URL for the Wallet pass signing cert.
	///   - password: The password
	func issue(using passCertURL: URL, password: String) throws -> Data {
		// Encode the pass to give to PassEncoder
		let encoder = JSONEncoder()
		encoder.dateEncodingStrategy = .iso8601

		let passData = try encoder.encode(properties)

		guard let passEncoder = PassEncoder.init(passData: passData) else {
			throw IssuingError.invalidPassData
		}

		for image in images {
			guard passEncoder.addFile(from: image) else {
				throw IssuingError.couldntAddFile(path: image.path)
			}
		}

		guard let encodedPass = passEncoder.encode(signingInfo: (certificate: passCertURL, password: password)) else {
			throw IssuingError.passSigningFailed
		}

		return encodedPass
	}
}
