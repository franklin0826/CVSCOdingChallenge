//
//  APIEndpoints.swift
//  CVSCodeChalleng
//
//  Created by Franklin Mott on 28/06/24.
//

import Foundation

struct Endpoints {
    static func imagesApiUrl(_ searchWord: String) -> String {
        return "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(searchWord)"
    }
}
