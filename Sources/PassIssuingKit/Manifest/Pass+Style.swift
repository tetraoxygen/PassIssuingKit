import Foundation

public extension Pass {
	/// The various pass styles supported by Wallet.
	enum Style: CodingKey {
		/// A Wallet pass styled as a boarding pass.
		case boardingPass
		/// A Wallet pass styled as a coupon.
		case coupon
		/// A Wallet pass styled as an event ticket.
		case eventTicket
		/// A Wallet pass styled as a store membership card.
		case storeCard
		/// A generic Wallet pass.
		case generic
	}

	/// The various pass styles supported by Wallet, containing a body.
	enum StyledBody: Codable {
		/// A Wallet pass styled as a boarding pass.
		case boardingPass(body: Body)
		/// A Wallet pass styled as a coupon.
		case coupon(body: Body)
		/// A Wallet pass styled as an event ticket.
		case eventTicket(body: Body)
		/// A Wallet pass styled as a store membership card.
		case storeCard(body: Body)
		/// A generic Wallet pass.
		case generic(body: Body)

		public var style: Style {
			switch self {
				case .boardingPass:
					return .boardingPass
				case .coupon:
					return .coupon
				case .eventTicket:
					return .eventTicket
				case .storeCard:
					return .storeCard
				case .generic:
					return .generic
			}
		}

		/// The body of the pass.
		public var body: Body {
			switch self {
				case .boardingPass(let body):
					return body
				case .coupon(let body):
					return body
				case .eventTicket(let body):
					return body
				case .storeCard(let body):
					return body
				case .generic(let body):
					return body
			}
		}

		public enum CodingKeys: CodingKey {
			case boardingPass
			case coupon
			case eventTicket
			case storeCard
			case generic
		}

		enum BoardingPassCodingKeys: CodingKey {
			case body
		}

		enum CouponCodingKeys: CodingKey {
			case body
		}

		enum EventTicketCodingKeys: CodingKey {
			case body
		}

		enum StoreCardCodingKeys: CodingKey {
			case body
		}

		enum GenericCodingKeys: CodingKey {
			case body
		}

		public init(from decoder: Decoder) throws {
			let container = try decoder.container(keyedBy: Pass.StyledBody.CodingKeys.self)
			var allKeys = ArraySlice(container.allKeys)
			guard let onlyKey = allKeys.popFirst(), allKeys.isEmpty else {
				throw DecodingError.typeMismatch(Pass.StyledBody.self, DecodingError.Context.init(codingPath: container.codingPath, debugDescription: "Invalid number of keys found, expected one.", underlyingError: nil))
			}
			switch onlyKey {
				case .boardingPass:
					let body = try Pass.Body(from: decoder)
					self = Pass.StyledBody.boardingPass(body: body)
				case .coupon:
					let body = try Pass.Body(from: decoder)
					self = Pass.StyledBody.eventTicket(body: body)
				case .eventTicket:
					let body = try Pass.Body(from: decoder)
					self = Pass.StyledBody.eventTicket(body: body)
				case .storeCard:
					let body = try Pass.Body(from: decoder)
					self = Pass.StyledBody.storeCard(body: body)
				case .generic:
					let body = try Pass.Body(from: decoder)
					self = Pass.StyledBody.generic(body: body)
			}
		}

		// Custom encoder so we don't encode 'body' as the parent.
		public func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: Style.self)

			try container.encode(body, forKey: style)
		}
	}
}
