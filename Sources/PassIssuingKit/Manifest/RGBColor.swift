import Foundation

/// A struct containing an RGB color.
public struct RGBColor {
	/// 0-1, the red value for the color.
	var red: Double
	/// 0-1, the blue value for the color.
	var blue: Double
	/// 0-1, the green value for the color.
	var green: Double
}

extension RGBColor: LosslessStringConvertible, Codable {
	/// Initialize from a hex string (but without the leading hash).
	public init?(hex: String) {
		guard hex.count == 6 else {
			return nil
		}

		let components = hex.split(every: 2)

		let doubleComponents = try? components.map { component -> Double in
			guard let intValue = Int(component, radix: 16) else {
				throw HexInitializationError.badNumber
			}

			let doubleValue = Double(intValue) / 255
			return doubleValue
		}

		guard let doubleComponents = doubleComponents else {
			return nil
		}

		self.init(red: doubleComponents[0], blue: doubleComponents[1], green: doubleComponents[2])
	}

	/// Initialize from a CSS-format RGB string (e.g, `rgb(255, 255, 255)`).
	public init?(rgb description: String) {
		var description = description

		guard description.removeFirst(3) == "rgb" else {
			return nil
		}

		description = description.trimmingCharacters(in: .init(charactersIn: "()"))

		let components = description.split(separator: ",")
		let trimmedComponents = components.map({ $0.trimmingCharacters(in: .whitespaces) })

		guard
			let redComponent = Int(trimmedComponents[0]),
			let blueComponent = Int(trimmedComponents[1]),
			let greenComponent = Int(trimmedComponents[2])
		else {
			return nil
		}

		self.red = Double(redComponent) / 255
		self.blue = Double(blueComponent) / 255
		self.green = Double(greenComponent) / 255
	}

	public enum HexInitializationError: Error {
		/// The given hex wasn't a valid Int.
		case badNumber
	}

	/// Initialize from a CSS RGB or hex value.
	public init?(_ description: String) {
		if let rgb = RGBColor(rgb: description) {
			self = rgb
		} else if let hex = RGBColor(hex: description) {
			self = hex
		}
		return nil
	}

	/// The description as an RGB-format string.
	public var description: String {
		let red = Int(self.red * 255)
		let blue = Int(self.blue * 255)
		let green = Int(self.green * 255)

		return "rgb(\(red), \(green), \(blue))"
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()

		guard let result = RGBColor(try container.decode(String.self)) else {
			throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Not valid RGB values."))
		}

		self = result
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()

		try container.encode(self.description)
	}
}
