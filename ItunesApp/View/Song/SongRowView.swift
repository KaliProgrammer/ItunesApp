//
//  SongRowView.swift
//  ItunesApp
//
//  Created by MacBook Air on 13.06.2023.
//

import SwiftUI

struct SongRowView: View {
    
    let song: Song
    
    var body: some View {
        HStack {
            
            ImageLoadingView(urlString: song.artworkUrl60 ?? "", size: 60)
            
            
            
            VStack(alignment: .leading) {
                Text(song.trackName ?? "")
                Text((song.artistName ?? "") + " - " + (song.collectionName ?? ""))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            .lineLimit(1)
            Spacer(minLength: 20)
            
            BuySongButtonView(urlString:
                        song.trackViewURL,
                        price: song.trackPrice ,
                        currency: song.currency)
           
        }
    }
}




struct SongListRowView_Previews: PreviewProvider {
    static var previews: some View {
        SongRowView(song: Song.example())
    }
}
