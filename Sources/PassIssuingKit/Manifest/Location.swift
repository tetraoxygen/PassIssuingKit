import Foundation

/// A struct representing a geographical location.
public struct Location: Codable, Equatable {
	/// The longitude of the location.
	public var longitude: Double
	/// The latitude of the location.
	public var latitude: Double
	/// The altitude, in meters, of the location.
	public var altitude: Double?
	/// Text displayed on the lock screen when the pass is currently relevant. For example, a description of the nearby location such as “Store nearby on 1st and Main.”
	public var relevantText: String?

	public init(longitude: Double, latitude: Double, altitude: Double? = nil, relevantText: String? = nil) {
		self.longitude = longitude
		self.latitude = latitude
		self.altitude = altitude
		self.relevantText = relevantText
	}
}
