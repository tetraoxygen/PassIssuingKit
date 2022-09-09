import Foundation

/// A struct representing a barcode object.
public struct Barcode: Codable, Equatable {
	/// The message to encode.
	public var message: String
	/// The format in which to encode it.
	public var format: BarcodeFormat
	/// The string encoding to use (IANA format).
	public var messageEncoding: String = "utf-8"

	/// Every barcode format supported by Apple Wallet.
	public enum BarcodeFormat: String, Codable {
		/// A QR code.
		case qr = "PKBarcodeFormatQR"
		/// A PDF417 code.
		case pdf417 = "PKBarcodeFormatPDF417"
		/// An Aztec code.
		case aztec = "PKBarcodeFormatAztec"
		/// A Code 128 format barcode. **Note: does not work on Apple Watch.**
		case code128 = "PKBarcodeFormatCode128"
	}

	public init(message: String, format: BarcodeFormat, messageEncoding: String) {
		self.message = message
		self.format = format
		self.messageEncoding = messageEncoding
	}
}
