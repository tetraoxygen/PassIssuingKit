import Foundation

public struct Pass {
	/// The properties of the pass.
	public var properties: Properties
	/// The URLs for the pass's images.
	public var images: [URL]

	public init(properties: Properties, images: [URL]) {
		self.properties = properties
		self.images = images
	}
}
