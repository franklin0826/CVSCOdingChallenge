//
//  FormatExtensions.swift
//  CVSCodeChalleng
//
//  Created by Franklin Mott on 28/06/24.
//

import Foundation

extension String {
    func extractImageWidthAndHeight() -> (width: Int, height: Int) {
        let regex = try! NSRegularExpression(pattern: "<img[^>]*width=\"(\\d+)\"[^>]*height=\"(\\d+)\"[^>]*>", options: .caseInsensitive)

        let match = regex.firstMatch(in: self, options: [], range: NSRange(startIndex..., in: self))

        if let match = match {
            let widthRange = match.range(at: 1)
            let heightRange = match.range(at: 2)

            let widthString = String(self[Range(widthRange, in: self)!])
            let heightString = String(self[Range(heightRange, in: self)!])

            let width = Int(widthString) ?? 0
            let height = Int(heightString) ?? 0

            return (width, height)
        } else {
            return (0, 0) // Return default values if not found
        }
    }
}

