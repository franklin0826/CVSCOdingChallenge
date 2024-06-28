//
//  ImagesResponseData.swift
//  CVSCodeChalleng
//
//  Created by Franklin Mott on 28/06/24.
//

import Foundation

// MARK: - ImagesResponseData
struct ImagesResponseData: Decodable {
    let title: String
    let items: [Item]
}

// MARK: - Item
struct Item: Decodable {
    let title: String
    let link: String
    let media: Media
    let dateTaken: String
    let description,published: String
    let author, authorId, tags: String
}

extension Item: Identifiable {
    var id: String {
        return dateTaken
    }
}

// MARK: - Media
struct Media: Decodable {
    let m: String
}
