//
//  ImagesGridViewModel.swift
//  CVSCodeChalleng
//
//  Created by Franklin Mott on 28/06/24.
//

import Foundation
import Combine
import CoreNetwork

protocol ImagesGridViewModelActions {
    func getImages(_ urlString: String) async
}

enum PhotoSearchViewStates {
    case loading(imagesList: [Item])
    case error(message: String)
}

final class ImagesGridViewModel: ObservableObject {
    
    @Published var photoSearchViewStates: PhotoSearchViewStates = .loading(imagesList: [])
    
    private let networkManager: NetworkAction
    let searchTextPublisher = PassthroughSubject<String, Never>()
    private var anyCancellable: AnyCancellable?
    init(networkManager: NetworkAction = NetworkManager()) {
        self.networkManager = networkManager
        bindSearch()
    }
    
    private func bindSearch() {
        anyCancellable = searchTextPublisher
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink { value in
                Task {
                    await self.getImages(Endpoints.imagesApiUrl(value))
                }
            }
    }
}

extension ImagesGridViewModel:ImagesGridViewModelActions {
    
    @MainActor
    func getImages(_ urlString: String) async {
        do {
            let imageData = try await networkManager.get(apiURL: urlString, type: ImagesResponseData.self)
            photoSearchViewStates = .loading(imagesList: imageData.items)
        } catch let error {
            photoSearchViewStates = .error(message: error.localizedDescription)
        }
    }
}
