# PassIssuingKit

A quick and simple Apple Wallet pass issuing library for Swift.

## Installation
### Swift Package Manager

Add the following line to your dependencies in `Package.swift`:
```
.package(url: "https://github.com/tetraoxygen/PassIssuingKit.git", from: "1.0.0")
```

## Usage

Before issuing passes, you'll need to go get the correct certs from the Apple Developer site. You can learn how to do that (here)[https://github.com/aydenp/PassEncoder#creating-and-preparing-your-certificate].

Once you've done that, issue a Pass like this: 
```swift
import PassIssuingKit

// You only have to do this once, it sets the WWDR cert location from then on.
Pass.setWWDRCert(at: signingConfig.wwdrCertLocation)

// Initialize the Pass object.
let pass = Pass(
	properties: .init(
		passTypeIdentifier: "YOUR_PASS_TYPE_ID",
		serialNumber: "SOME_SERIAL",
		teamIdentifier: "YOUR_TEAM_ID",
		webServiceURL: "YOUR_WEB_SERVICE_URL",
		authenticationToken: "SOME_TOKEN",
		logoText: "Logo Text Write",
		organizationName: "Logo Text, Inc.",
		description: "Your ticket to Logo Text Write",
		style: .generic(body: .init())
	),
	images: [
		// Put any image URLs here and they'll get copied to the pass bundle.
	]
)

// You now have the pass data to do what you want with!
let passData = try pass.issue(using: signingCertURL, signingCertPassword)
```
