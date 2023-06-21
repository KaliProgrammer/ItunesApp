//
//  AlbumDetailView.swift
//  ItunesApp
//
//  Created by MacBook Air on 14.06.2023.
//

import SwiftUI

struct AlbumDetailView: View {
    
    @StateObject var songsViewModel: SongsForAlbumListViewModel
    let album: Album
    
    
    init(album: Album) {
        self.album = album
        self._songsViewModel = StateObject(wrappedValue: SongsForAlbumListViewModel(albumID: album.collectionID ?? 0))
    }
    var body: some View {
        VStack {
            AlbumHeaderDetailView(album: album)
            
            SongsForAlbumListView(viewModel: songsViewModel, selectedSong: nil)
        }
        .onAppear {
            songsViewModel.fetch()
        }
    }
}

struct AlbumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetailView(album: Album.example())
    }
}

struct AlbumHeaderDetailView: View {
    
    let album: Album
    
    var body: some View {
        
      

        HStack(alignment: .bottom) {
            ImageLoadingView(urlString: album.artworkUrl100 ?? "", size: 100)
            VStack(alignment: .leading) {
                Text(album.collectionName ?? "")
                    .font(.footnote)
                    .foregroundColor(Color(.label))
                Text(album.artistName ?? "")
                    .padding(.bottom, 5)
                
                Text(album.primaryGenreName ?? "")
                Text("\(album.trackCount ?? 0) songs")
                Text("Released: \(formattedDate(value:album.releaseDate ?? ""))")
            }
            .font(.caption)
            .foregroundColor(.gray)
            .lineLimit(1)
            
            Spacer()
            
            BuyButtonView(urlString: album.collectionViewURL, price: album.collectionPrice, currency: album.currency)
        }
        .padding()
        .background(
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.top)
                .shadow(radius: 5)
        )
    }
    
    func formattedDate(value: String) -> String {
       let dateFormatterGetter = DateFormatter()
        dateFormatterGetter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        guard let date = dateFormatterGetter.date(from: value) else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
       return dateFormatter.string(from: date)
    }
}
