import Foundation

/// A struct that handles environment variables.
struct Environment {
	/// Gets an environment variable and converts it to a provided type, leaving it as a string if no conversion is specified.
	static func get<T>(key: String, conversion: (_ stringValue: String) -> T? = { return $0 }) throws -> T {
		guard let value = ProcessInfo.processInfo.environment[key] else {
			throw EnvironmentError.variableDoesntExist
		}

		guard let converted = conversion(value) else {
			throw EnvironmentError.conversionFailed
		}

		return converted
	}

	/// Gets an environment variable containing a file path and converts it to a URL.
	static func get(key: String) throws -> URL {
		return try Self.get(key: key) { stringValue in
			URL(fileURLWithPath: stringValue)
		}
	}

	/// Errors relating to environment variables.
	enum EnvironmentError: Error {
		/// The environment variable didn't exist.
		case variableDoesntExist
		/// The conversion of the environment variable failed.
		case conversionFailed
	}
}
