import Foundation

public extension Pass {
	/// A pass's body.
	struct Body: Codable, Equatable {
		/// The primary fields of the pass.
		public var primaryFields: [TypedField]?
		/// The secondary fields of the pass.
		public var secondaryFields: [TypedField]?
		/// The auxiliary fields of the pass.
		public var auxiliaryFields: [TypedField]?
		/// The header fields of the pass.
		public var headerFields: [TypedField]?
		/// The back fields of the pass.
		public var backFields: [TypedField]?

		public init(primaryFields: [TypedField]? = nil, secondaryFields: [TypedField]? = nil, auxiliaryFields: [TypedField]? = nil, headerFields: [TypedField]? = nil, backFields: [TypedField]? = nil) {
			self.primaryFields = primaryFields
			self.secondaryFields = secondaryFields
			self.auxiliaryFields = auxiliaryFields
			self.headerFields = headerFields
			self.backFields = backFields
		}
	}
}
