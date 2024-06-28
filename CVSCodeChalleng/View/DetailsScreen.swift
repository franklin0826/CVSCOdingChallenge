//
//  DetailsScreen.swift
//  CVSCodeChalleng
//
//  Created by Franklin Mott on 28/06/24.
//

import SwiftUI

struct DetailsScreen: View {
    
    let cellData: Item
    var namespace: Namespace.ID
    
    @State private var isSharing = false
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        GeometryReader { geometry in
            if sizeClass == .compact {
                // Portrait layout
                VStack {
                    imageView
                    textView
                    authorView
                    imageDimensions
                    shareButton
                }.padding()
            } else {
                // Landscape layout
                HStack {
                    imageView
                        .frame(width: geometry.size.width / 2)
                    VStack {
                        textView
                        authorView
                        imageDimensions
                        shareButton
                    }
                }
            }
        }
    }
    
    private var imageView: some View {
        Group{
            AsyncImage(url: URL(string: cellData.media.m)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .matchedGeometryEffect(id: cellData.media.m, in: namespace)
            .padding()
        }.accessibilityElement()
        .accessibilityAddTraits(.isImage)
        .accessibilityLabel(Text("This is a \(cellData.title) Image shown here"))
    }
    
    private var textView: some View {
        Text("Title: \(cellData.title)")
            .font(.title)
            .accessibilityLabel("Image title: \(cellData.title)")
            .accessibilityAddTraits(.isStaticText)
    }
    
    private var authorView: some View {
            Text("Author Details: \(cellData.author)")
            .accessibilityLabel(Text("This is a Image Author Details  as \(cellData.author)"))
            .accessibilityAddTraits(.isStaticText)
    }
    
    private var imageDimensions: some View {
        Text("Image Dimensions Width: \(cellData.description.extractImageWidthAndHeight().0), Height: \(cellData.description.extractImageWidthAndHeight().1)")
            .accessibilityHidden(true) // this is not important enough to used as VoiceOver, so I am hiding it from VoiceOver detection
    }
    
    private var shareButton: some View {
        Button(action: {
            isSharing = true
        }, label: {
            Image(systemName: "square.and.arrow.up")
            Text("Share")
        }).buttonStyle(.bordered)
        .accessibilityLabel(Text("Click this button to share."))
        .sheet(isPresented: $isSharing, content: {
            ShareView(activityItems: [URL(string: cellData.media.m) as Any, cellData.title])
        })
    }
}

#Preview {
    DetailsScreen(cellData: Item(title: "Horned Lark", link: "https://www.flickr.com/photos/amketter/53469306909/", media: Media(m: "https://live.staticflickr.com/65535/53469340586_41dbf5e79c_m.jpg"), dateTaken: "", description: "", published: "", author: "nobody@flickr.com", authorId: "", tags: ""), namespace: Namespace().wrappedValue)
}
