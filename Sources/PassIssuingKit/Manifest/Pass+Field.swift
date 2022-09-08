import Foundation

public extension Pass {
	// TODO: Make decoding actually work with the encoded results
	struct Field: Codable {
		/// The key for the field.
		public var key: String
		/// The value of the field.
		public var value: String
		/// The label for the field.
		public var label: String?
		/// The message to show the user when the pass is updated.
		public var changeMessage: String?
		/// The data detectors that are applies to the field's value. Only applied to back fields.
		public var dataDetectorTypes: [DataDetectors]?
		/// The text alignment of the field.
		public var textAlignment: TextAlignment?
		/// The formatting of the field.
		public var formatting: Formatting?

		public enum Formatting: Codable {
			public struct DateStyleOptions: Codable {
				public var dateStyle: DateTimeStyle
				public var timeStyle: DateTimeStyle?
				public var isRelative: Bool = true
				public var ignoresTimeZone: Bool?
			}

			case dateStyle(
				options: DateStyleOptions
			)
			case numberStyle(_ style: NumberStyle)
			case currencyStyle(code: String)

			var body: Codable {
				switch self {
					case .dateStyle(let options):
						return options
					case .numberStyle(let style):
						return style
					case .currencyStyle(let code):
						return code
				}
			}

			public func encode(to encoder: Encoder) throws {
				try body.encode(to: encoder)
			}
		}

		public func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: CodingKeys.self)

			try container.encode(key, forKey: .key)
			try container.encode(value, forKey: .value)
			try container.encodeIfPresent(label, forKey: .label)
			try container.encodeIfPresent(changeMessage, forKey: .changeMessage)
			try container.encodeIfPresent(dataDetectorTypes, forKey: .dataDetectorTypes)
			try container.encodeIfPresent(textAlignment, forKey: .textAlignment)
			try formatting?.encode(to: encoder)
		}

		public enum TextAlignment: String, Codable {
			case left = "PKTextAlignmentLeft"
			case center = "PKTextAlignmentCenter"
			case right = "PKTextAlignmentRight"
			case natural = "PKTextAlignmentNatural"
		}

		public enum DataDetectors: String, Codable {
			case phoneNumber = "PKDataDetectorTypePhoneNumber"
			case link = "PKDataDetectorTypeLink"
			case address = "PKDataDetectorTypeAddress"
			case calendarEvent = "PKDataDetectorTypeCalendarEvent"
		}

		public enum DateTimeStyle: String, Codable {
			case none =  "PKDateStyleNone"
			case short =  "PKDateStyleShort"
			case medium =  "PKDateStyleMedium"
			case long =  "PKDateStyleLong"
			case full =  "PKDateStyleFull"
		}

		public enum NumberStyle: String, Codable {
			case decimal = "PKNumberStyleDecimal"
			case percent = "PKNumberStylePercent"
			case scientific = "PKNumberStyleScientific"
			case spellOut = "PKNumberStyleSpellOut"
		}
	}
}
