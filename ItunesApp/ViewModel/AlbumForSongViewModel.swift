//
//  AlbumForSongViewModel.swift
//  ItunesApp
//
//  Created by MacBook Air on 19.06.2023.
//

import Foundation

class AlbumForSongViewModel: ObservableObject {
    
    @Published var album: Album? = nil
    @Published var state: FetchState = .good

    let service: APIService = .init()
    
    func fetch(song: Song) {
        
        guard let albumId = song.collectionID  else { return }
        
        state = .isLoading
        
        
        service.fetchAlbum(for: albumId) {[weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    self.album = result.results.first
                case .failure(let error):
                    self.state = .error(error.localizedDescription)
                }
            } 
        }
    }
}
