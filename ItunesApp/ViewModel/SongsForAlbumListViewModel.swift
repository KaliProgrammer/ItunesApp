//
//  SongsForAlbumListViewModel.swift
//  ItunesApp
//
//  Created by MacBook Air on 16.06.2023.
//

import Foundation

class SongsForAlbumListViewModel: ObservableObject {
    
    @Published var songs: [Song] = []
    @Published var state: FetchState = .good
    
    let albumID: Int
    let service = APIService()
    
    init(albumID: Int) {
        self.albumID = albumID  
    }
    
    func fetch() {
        fetchSongs(for: albumID)
    }
    
   private func fetchSongs(for albumID: Int) {
        service.fetchSongs(for: albumID) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    var songs = result.results
                    
                    if result.resultCount > 0 {
                        _ = songs.removeFirst()
                    }
                    
                    
                    self?.songs = songs
                   
                    self?.state = .good
                    print("Fetched \(result.resultCount) songs for albumID: \(albumID)")
                case .failure(let error):
                    self?.state = .error("Could not load: \(error.localizedDescription)")
                }
            }
        }
    }
    
    static func example() -> SongsForAlbumListViewModel {
        let vm = SongsForAlbumListViewModel(albumID: 1441132965)
        vm.songs = [Song.example()]
        return vm
    }
}
