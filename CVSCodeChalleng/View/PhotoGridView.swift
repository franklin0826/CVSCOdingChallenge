//
//  PhotoGridView.swift
//  CVSCodeChalleng
//
//  Created by Franklin Mott on 28/06/24.
//

import SwiftUI
import Combine

struct PhotoGridView: View {
    @StateObject var viewModel = ImagesGridViewModel()
    @Namespace private var imageNamespace
    @Environment(\.horizontalSizeClass) var sizeClass
    @State var searchText: String = ""

    // Adjust the number of columns for landscape mode
    private var gridColumns: [GridItem] {
        let numberOfColumns = sizeClass == .compact ? 2 : 4 // the right-side is the landscape
        return Array(repeating: .init(.flexible()), count: numberOfColumns)
    }
    
    var body: some View {
        NavigationStack {
            searchView(gridColumns)
                .searchable(text: $searchText,
                            placement: .automatic,
                            prompt: "Search")
                .onChange(of: searchText, initial: true) { searchText, newVlaue in
                    viewModel.searchTextPublisher.send(newVlaue)
                }
                .navigationTitle("Home")
        }
    }
    
    @ViewBuilder
    private func searchView(_ columns: [GridItem]) -> some View {
        switch viewModel.photoSearchViewStates {
        case .loading(imagesList: let imagesList):
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(imagesList) { imageData in
                        NavigationLink(destination: DetailsScreen(cellData: imageData, namespace: imageNamespace)) {
                            GridViewCell(cellData: imageData, namespace: imageNamespace)
                                .frame(width: 120,height: 120)
                        }
                    }
                }
            }
        case .error(message: let message):
            Text(message)
                .padding()
        }
    }
}

#Preview {
    PhotoGridView()
}

