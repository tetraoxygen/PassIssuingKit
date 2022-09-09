import Foundation

public extension Pass {
	/// The various pass styles supported by Wallet.
	enum Style: CodingKey, Equatable {
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
	enum StyledBody: Codable, Equatable {
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

		public init(from decoder: Decoder) throws {
			let container = try decoder.container(keyedBy: Style.self)

			if let body = try? container.decodeIfPresent(Body.self, forKey: .boardingPass) {
				self = .boardingPass(body: body)
			} else if let body = try? container.decodeIfPresent(Body.self, forKey: .coupon) {
				self = .coupon(body: body)
			} else if let body = try? container.decodeIfPresent(Body.self, forKey: .eventTicket) {
				self = .eventTicket(body: body)
			} else if let body = try? container.decodeIfPresent(Body.self, forKey: .storeCard) {
				self = .storeCard(body: body)
			} else {
				let body = try container.decode(Body.self, forKey: .generic)
				self = .generic(body: body)
			}
		}

		// Custom encoder so we don't encode 'body' as the parent.
		public func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: Style.self)

			try container.encode(body, forKey: style)
		}
	}
}
