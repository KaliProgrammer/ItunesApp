//
//  MovieRowView.swift
//  ItunesApp
//
//  Created by MacBook Air on 13.06.2023.
//

import SwiftUI

struct MovieRowView: View {
    let movie: Movie
    
    var body: some View {
        HStack {
            ImageLoadingView(urlString: movie.artworkUrl100 ?? "", size: 100)
            VStack(alignment: .leading) {
                Text(movie.trackName ?? "")
                Text(movie.primaryGenreName ?? "")
                    .foregroundColor(.gray)
                Text(movie.releaseDate ?? "")
                   
            }
            .lineLimit(1)
            
            Spacer(minLength: 20)
            
            BuyButtonView(urlString: movie.previewURL, price: movie.trackPrice, currency: movie.currency)
        }
    }
}

struct MovieRowView_Previews: PreviewProvider {
    static var previews: some View {
        MovieRowView(movie: Movie.example())
    }
}
