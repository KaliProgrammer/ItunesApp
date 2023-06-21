//
//  AlbumListViewModel.swift
//  ItunesApp
//
//  Created by MacBook Air on 11.06.2023.
//

import Foundation
import Combine

/*
 https://itunes.apple.com/search?term=jack+johnson&entity=album&limit=5&pffset=10
 https://itunes.apple.com/search?term=jack+johnson&entity=song&limit=5
 https://itunes.apple.com/search?term=jack+johnson&entity=movie&limit=5
 */

class AlbumListViewModel: ObservableObject {
    
   
    @Published var searchTerm: String = ""
    @Published var state: FetchState = .good
    @Published var albums: [Album] = [Album]()
    
    var page: Int = 0
    let limit: Int = 20
    
    private var cancellables = Set<AnyCancellable>()

    let apiService = APIService()
    
    init() {
        $searchTerm
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.clear()
                self?.fetchAlbums(for: term)
                
            }
            .store(in: &cancellables)
    }
    
    func clear() {
        self.state = .good
        self.albums = []
        self.page = 0
    }
    
    func loadMore() {
        fetchAlbums(for: searchTerm)
    }
    
    static func example() -> AlbumListViewModel {
        let vm = AlbumListViewModel()
        vm.albums = [Album.example()]
        return vm
    }
    
    func fetchAlbums(for searchTerm: String) {
        
        guard !searchTerm.isEmpty else {
            return
        }
        
        guard state == FetchState.good else {
            return
        }
        
        state = .isLoading
        
        apiService.fetchAlbums(searchTerm: searchTerm, page: page, limit: limit) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    result.results.forEach { self?.albums.append($0) }
                    self?.page += 1
                    
                    self?.state = (result.results.count == self?.limit) ? .good : .loadedAll
                    print("Fetched albums: \(result.resultCount)")
                case .failure(let error):
                    self?.state = .error("Could not load: \(error.localizedDescription)")
                }
            }
        }
    }
}
