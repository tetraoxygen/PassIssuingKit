import Foundation

public extension Pass {
	/// A pass's body.
	struct Body: Codable {
		/// The primary fields of the pass.
		public var primaryFields: [Field]?
		/// The secondary fields of the pass.
		public var secondaryFields: [Field]?
		/// The auxiliary fields of the pass.
		public var auxiliaryFields: [Field]?
		/// The header fields of the pass.
		public var headerFields: [Field]?
		/// The back fields of the pass.
		public var backFields: [Field]?

		public init(primaryFields: [Field]? = nil, secondaryFields: [Field]? = nil, auxiliaryFields: [Field]? = nil, headerFields: [Field]? = nil, backFields: [Field]? = nil) {
			self.primaryFields = primaryFields
			self.secondaryFields = secondaryFields
			self.auxiliaryFields = auxiliaryFields
			self.headerFields = headerFields
			self.backFields = backFields
		}
	}
}
