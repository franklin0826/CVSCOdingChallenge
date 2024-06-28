//
//  GridViewCell.swift
//  CVSCodeChalleng
//
//  Created by Franklin Mott on 28/06/24.
//

import SwiftUI

struct GridViewCell: View {
    
    let cellData: Item
    var namespace: Namespace.ID
    var body: some View {
        VStack(spacing: 10) {
            AsyncImage(url: URL(string: cellData.media.m)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            } placeholder: {
                ProgressView().frame(width: 100, height: 100)
            }
            .matchedGeometryEffect(id: cellData.media.m, in: namespace)
            .accessibilityHint("Image \(cellData.title)")
            Text(cellData.title)
                .font(.body) // body is a very good start off for Dynamic Type
                .foregroundStyle(.black)
                .accessibilityLabel("Title: \(cellData.title)")
            
        }
    }
}

#Preview {
    GridViewCell(cellData: Item(title: "Horned Lark", link: "https://www.flickr.com/photos/amketter/53469306909/", media: Media(m: "https://live.staticflickr.com/65535/53469340586_41dbf5e79c_m.jpg"), dateTaken: "", description: "", published: "", author: "nobody@flickr.com", authorId: "", tags: ""), namespace: Namespace().wrappedValue)
}
