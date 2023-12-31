//
//  AlbumRowView.swift
//  ItunesApp
//
//  Created by MacBook Air on 13.06.2023.
//

import SwiftUI

struct AlbumRowView: View {
    
    let album: Album
    
    var body: some View {
        HStack {
            ImageLoadingView(urlString: album.artworkUrl100 ?? "", size: 100)
            VStack(alignment: .leading) {
                Text(album.collectionName ?? "")
                Text(album.artistName ?? "")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .lineLimit(1)
            
            Spacer()
            
            BuyButtonView(urlString: album.collectionViewURL, price: album.collectionPrice, currency: album.currency)
        }
    }
}

struct AlbumRowView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumRowView(album: Album.example())
    }
}
