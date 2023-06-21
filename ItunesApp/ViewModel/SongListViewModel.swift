//
//  SongListViewModel.swift
//  ItunesApp
//
//  Created by MacBook Air on 12.06.2023.
//

import Foundation
import Combine

class SongListViewModel: ObservableObject {
    @Published var searchTerm: String = ""
    @Published var songs: [Song] = []
    @Published var state: FetchState = .good
    private var cancellables = Set<AnyCancellable>()
    
    let apiService = APIService()
    let limit: Int = 20
    var page: Int = 0
    
    init() {
        $searchTerm
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.clear()
                self?.fetchSongs(for: term)
                
            }
            .store(in: &cancellables)
    }
    
    func clear() {
        self.state = .good
        self.songs = []
        self.page = 0
    }
    
    func loadMore() {
        fetchSongs(for: searchTerm)
    }
    
    func fetchSongs(for searchTerm: String) {
        guard !searchTerm.isEmpty else {
            return
        }
        
        guard state == FetchState.good else {
            return
        }
        
        state = .isLoading
        
        apiService.fetchSongs(searchTerm: searchTerm, page: page, limit: limit) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    result.results.forEach { self?.songs.append($0) }
                    self?.page += 1
                    
                    self?.state = (result.results.count == self?.limit) ? .good : .loadedAll
                    print("Fetched songs: \(result.resultCount)")
                case .failure(let error):
                    self?.state = .error("Could not load: \(error.localizedDescription)")
                }
            }
        }
    }
    
    static func example() -> SongListViewModel {
        let vm = SongListViewModel()
        vm.songs = [Song.example()]
        return vm
    }
}
