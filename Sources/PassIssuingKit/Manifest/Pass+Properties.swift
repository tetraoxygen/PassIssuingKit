import Foundation

extension Pass {
	/// The manifest of the pass.
	public struct Properties: Codable {
		/// The Pass format version. Should be 1.
		public var formatVersion: Int = 1
		/// The reverse-DNS pass identifier.
		public var passTypeIdentifier: String
		/// A serial number for the Pass.
		public var serialNumber: String
		/// The Apple Developer Team ID of the issuing account.
		public var teamIdentifier: String
		/// The URL to the web service for the pass (as described in the pass docs).
		public var webServiceURL: URL
		/// The authentication token for the pass update web service. A minimum of 16 characters.
		public var authenticationToken: String
		/// The relevant date for the event.
		public var relevantDate: Date?
		/// The foreground color for the pass (for text and whatnot).
		public var foregroundColor: RGBColor?
		/// The background color for the pass.
		public var backgroundColor: RGBColor?
		/// The color for the labels (the small text).
		public var labelColor: RGBColor?
		/// The relevant locations for the pass.
		public var locations: [Location]?
		/// The barcodes for the pass.
		public var barcodes: [Barcode]?
		/// The text that goes next to the logo.
		public var logoText: String
		/// The name of the issuing organization.
		public var organizationName: String
		/// A short description of the pass.
		public var description: String

		/// The style of the pass.
		public var style: StyledBody

		public enum CodingKeys: CodingKey {
			case formatVersion
			case passTypeIdentifier
			case serialNumber
			case teamIdentifier
			case webServiceURL
			case authenticationToken
			case relevantDate
			case foregroundColor
			case backgroundColor
			case labelColor
			case locations
			case barcodes
			case logoText
			case organizationName
			case description
			case style
		}

		public func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: CodingKeys.self)
			try container.encode(formatVersion, forKey: .formatVersion)
			try container.encode(passTypeIdentifier, forKey: .passTypeIdentifier)
			try container.encode(serialNumber, forKey: .serialNumber)
			try container.encode(teamIdentifier, forKey: .teamIdentifier)
			try container.encode(webServiceURL, forKey: .webServiceURL)
			try container.encode(authenticationToken, forKey: .authenticationToken)
			try container.encodeIfPresent(relevantDate, forKey: .relevantDate)
			try container.encodeIfPresent(foregroundColor, forKey: .foregroundColor)
			try container.encodeIfPresent(backgroundColor, forKey: .backgroundColor)
			try container.encodeIfPresent(labelColor, forKey: .labelColor)
			try container.encodeIfPresent(locations, forKey: .locations)
			try container.encodeIfPresent(barcodes, forKey: .barcodes)
			try container.encode(logoText, forKey: .logoText)
			try container.encode(organizationName, forKey: .organizationName)
			try container.encode(description, forKey: .description)
			try style.encode(to: encoder)
		}

		public init(from decoder: Decoder) throws {
			let container: KeyedDecodingContainer<Pass.Properties.CodingKeys> = try decoder.container(keyedBy: Pass.Properties.CodingKeys.self)
			self.formatVersion = try container.decode(Int.self, forKey: Pass.Properties.CodingKeys.formatVersion)
			self.passTypeIdentifier = try container.decode(String.self, forKey: Pass.Properties.CodingKeys.passTypeIdentifier)
			self.serialNumber = try container.decode(String.self, forKey: Pass.Properties.CodingKeys.serialNumber)
			self.teamIdentifier = try container.decode(String.self, forKey: Pass.Properties.CodingKeys.teamIdentifier)
			self.webServiceURL = try container.decode(URL.self, forKey: Pass.Properties.CodingKeys.webServiceURL)
			self.authenticationToken = try container.decode(String.self, forKey: Pass.Properties.CodingKeys.authenticationToken)
			self.relevantDate = try container.decodeIfPresent(Date.self, forKey: Pass.Properties.CodingKeys.relevantDate)
			self.foregroundColor = try container.decodeIfPresent(RGBColor.self, forKey: Pass.Properties.CodingKeys.foregroundColor)
			self.backgroundColor = try container.decodeIfPresent(RGBColor.self, forKey: Pass.Properties.CodingKeys.backgroundColor)
			self.labelColor = try container.decodeIfPresent(RGBColor.self, forKey: Pass.Properties.CodingKeys.labelColor)
			self.locations = try container.decodeIfPresent([Location].self, forKey: Pass.Properties.CodingKeys.locations)
			self.barcodes = try container.decodeIfPresent([Barcode].self, forKey: Pass.Properties.CodingKeys.barcodes)
			self.logoText = try container.decode(String.self, forKey: Pass.Properties.CodingKeys.logoText)
			self.organizationName = try container.decode(String.self, forKey: Pass.Properties.CodingKeys.organizationName)
			self.description = try container.decode(String.self, forKey: Pass.Properties.CodingKeys.description)
			self.style = try .init(from: decoder)
		}

		public init(formatVersion: Int = 1, passTypeIdentifier: String, serialNumber: String, teamIdentifier: String, webServiceURL: URL, authenticationToken: String, relevantDate: Date? = nil, foregroundColor: RGBColor? = nil, backgroundColor: RGBColor? = nil, labelColor: RGBColor? = nil, locations: [Location]? = nil, barcodes: [Barcode]? = nil, logoText: String, organizationName: String, description: String, style: StyledBody) {
			self.formatVersion = formatVersion
			self.passTypeIdentifier = passTypeIdentifier
			self.serialNumber = serialNumber
			self.teamIdentifier = teamIdentifier
			self.webServiceURL = webServiceURL
			self.authenticationToken = authenticationToken
			self.relevantDate = relevantDate
			self.foregroundColor = foregroundColor
			self.backgroundColor = backgroundColor
			self.labelColor = labelColor
			self.locations = locations
			self.barcodes = barcodes
			self.logoText = logoText
			self.organizationName = organizationName
			self.description = description
			self.style = style
		}
	}
}
