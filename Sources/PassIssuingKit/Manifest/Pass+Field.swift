import Foundation

public protocol PassField: Codable, Equatable, Hashable {
	associatedtype ValueType: Codable

	/// The key for the field.
	var key: String { get set }
	/// The value of the field.
	var value: ValueType { get set }
	/// The label for the field.
	var label: String? { get set }
	/// A format string for the alert text to display when the pass is updated. The format string must contain the escape %@, which is replaced with the field’s new value. For example, “Gate changed to %@”.
	/// You must provide a value for the system to show a change notification.
	/// This field isn’t used for watchOS.
	var changeMessage: String? { get set }
	/// The data detectors that are applies to the field's value. Only applied to back fields.
	var dataDetectorTypes: [Pass.DataDetectors]? { get set }
	/// The text alignment of the field.
	var textAlignment: Pass.TextAlignment? { get set }
}

public extension Pass {
	enum TypedField: Codable, Equatable {
		case generic(_ field: GenericField)
		case currency(_ field: CurrencyField)
		case number(_ field: NumberField)
		case date(_ field: DateField)

		var field: any PassField {
			switch self {
				case .generic(let field):
					return field
				case .currency(let field):
					return field
				case .number(let field):
					return field
				case .date(let field):
					return field
			}
		}

		public func encode(to encoder: Encoder) throws {
			try field.encode(to: encoder)
		}

		public init(from decoder: Decoder) throws {
			if let dateField = try? DateField(from: decoder) {
				self = .date(dateField)
			} else if let currencyField = try? CurrencyField(from: decoder) {
				self = .currency(currencyField)
			} else if let numberField = try? NumberField(from: decoder) {
				self = .number(numberField)
			} else {
				let genericField = try GenericField(from: decoder)
				self = .generic(genericField)
			}
		}
	}
	/// A generic field with no special formatting.
	struct GenericField: PassField {
		public var key: String
		public var value: String
		public var label: String?
		public var changeMessage: String?
		public var dataDetectorTypes: [DataDetectors]?
		public var textAlignment: TextAlignment?

		public init(key: String, value: String, label: String? = nil, changeMessage: String? = nil, dataDetectorTypes: [DataDetectors]? = nil, textAlignment: TextAlignment? = nil) {
			self.key = key
			self.value = value
			self.label = label
			self.changeMessage = changeMessage
			self.dataDetectorTypes = dataDetectorTypes
			self.textAlignment = textAlignment
		}
	}

	/// A field for currency.
	struct CurrencyField: PassField {
		public var key: String
		public var value: Double
		public var label: String?
		public var changeMessage: String?
		public var dataDetectorTypes: [DataDetectors]?
		public var textAlignment: TextAlignment?
		/// The ISO-4217 format currency code to use for the value of the field.
		public var currencyCode: String

		public init(key: String, value: Double, label: String? = nil, changeMessage: String? = nil, dataDetectorTypes: [DataDetectors]? = nil, textAlignment: TextAlignment? = nil, currencyCode: String) {
			self.key = key
			self.value = value
			self.label = label
			self.changeMessage = changeMessage
			self.dataDetectorTypes = dataDetectorTypes
			self.textAlignment = textAlignment
			self.currencyCode = currencyCode
		}
	}

	/// A field for numbers.
	struct NumberField: PassField {
		public var key: String
		public var value: Double
		public var label: String?
		public var changeMessage: String?
		public var dataDetectorTypes: [DataDetectors]?
		public var textAlignment: TextAlignment?
		/// The style of the number to display in the field.
		public var numberStyle: NumberStyle

		public init(key: String, value: Double, label: String? = nil, changeMessage: String? = nil, dataDetectorTypes: [DataDetectors]? = nil, textAlignment: TextAlignment? = nil, numberStyle: NumberStyle) {
			self.key = key
			self.value = value
			self.label = label
			self.changeMessage = changeMessage
			self.dataDetectorTypes = dataDetectorTypes
			self.textAlignment = textAlignment
			self.numberStyle = numberStyle
		}
	}

	struct DateField: PassField {
		public var key: String
		public var value: String
		public var label: String?
		public var changeMessage: String?
		public var dataDetectorTypes: [DataDetectors]?
		public var textAlignment: TextAlignment?
		/// The style of the date to display in the field.
		public var dateStyle: DateTimeStyle
		/// The style of the time displayed in the field.
		public var timeStyle: DateTimeStyle?
		/// A Boolean value that controls whether the date appears as a relative date. The default value is false, which displays the date as an absolute date.
		public var isRelative: Bool?
		/// A Boolean value that controls the time zone for the time and date to display in the field. The default value is false, which displays the time and date using the current device’s time zone. Otherwise, the time and date appear in the time zone associated with the date and time of value.
		public var ignoresTimeZone: Bool?

		public init(key: String, value: String, label: String? = nil, changeMessage: String? = nil, dataDetectorTypes: [DataDetectors]? = nil, textAlignment: TextAlignment? = nil, dateStyle: DateTimeStyle, timeStyle: DateTimeStyle? = nil, isRelative: Bool? = nil, ignoresTimeZone: Bool? = nil) {
			self.key = key
			self.value = value
			self.label = label
			self.changeMessage = changeMessage
			self.dataDetectorTypes = dataDetectorTypes
			self.textAlignment = textAlignment
			self.dateStyle = dateStyle
			self.timeStyle = timeStyle
			self.isRelative = isRelative
			self.ignoresTimeZone = ignoresTimeZone
		}
	}

	enum TextAlignment: String, Codable {
		case left = "PKTextAlignmentLeft"
		case center = "PKTextAlignmentCenter"
		case right = "PKTextAlignmentRight"
		case natural = "PKTextAlignmentNatural"
	}

	enum DataDetectors: String, Codable, Equatable {
		case phoneNumber = "PKDataDetectorTypePhoneNumber"
		case link = "PKDataDetectorTypeLink"
		case address = "PKDataDetectorTypeAddress"
		case calendarEvent = "PKDataDetectorTypeCalendarEvent"
	}

	enum DateTimeStyle: String, Codable, Equatable {
		case none =  "PKDateStyleNone"
		case short =  "PKDateStyleShort"
		case medium =  "PKDateStyleMedium"
		case long =  "PKDateStyleLong"
		case full =  "PKDateStyleFull"
	}

	enum NumberStyle: String, Codable, Equatable {
		case decimal = "PKNumberStyleDecimal"
		case percent = "PKNumberStylePercent"
		case scientific = "PKNumberStyleScientific"
		case spellOut = "PKNumberStyleSpellOut"
	}
}
