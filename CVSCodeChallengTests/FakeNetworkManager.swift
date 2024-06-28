//
//  FakeNetworkManager.swift
//  CVSCodeChallengTests
//
//  Created by Franklin Mott on 28/06/24.
//

import Foundation
@testable import CVSCodeChalleng
import CoreNetwork


class FakeNetworkManager: NetworkAction {
    func get<T>(apiURL: String, type: T.Type) async throws -> T where T : Decodable {
        if apiURL.isEmpty {
            throw APIError.urlError
        }
        return ImagesResponseData.imageResponseData as! T
    }
}

extension ImagesResponseData {
    static var imageResponseData: ImagesResponseData {
        ImagesResponseData(title:"", items: [Item(title: "", link: "", media: Media(m: ""), dateTaken: "", description: "", published: "", author: "", authorId: "", tags: "")])
    }
}
