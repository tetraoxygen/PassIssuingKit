import Foundation

extension Pass {
	enum IssuingError: Error {
		/// The provided pass manifest was not valid JSON.
		case invalidPassData
		/// A provided file couldn't be added to the pass bundle.
		case couldntAddFile(path: String)
		/// Signing the pass failed.
		case passSigningFailed
	}
}
