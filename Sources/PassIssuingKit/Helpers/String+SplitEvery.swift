import Foundation

extension String {
	/// Splits a string into groups of `every` n characters, grouping from left-to-right by default. If `backwards` is true, right-to-left.
	public func split(every: Int, backwards: Bool = false) -> [Substring] {
		var result = [Substring]()

		for i in stride(from: 0, to: self.count, by: every) {
			switch backwards {
				case true:
					let endIndex = self.index(self.endIndex, offsetBy: -i)
					let startIndex = self.index(endIndex, offsetBy: -every, limitedBy: self.startIndex) ?? self.startIndex
					result.insert(self[startIndex..<endIndex], at: 0)
				case false:
					let startIndex = self.index(self.startIndex, offsetBy: i)
					let endIndex = self.index(startIndex, offsetBy: every, limitedBy: self.endIndex) ?? self.endIndex
					result.append(self[startIndex..<endIndex])
			}
		}

		return result
	}
}
