//
//  SongSectionView.swift
//  ItunesApp
//
//  Created by MacBook Air on 13.06.2023.
//

import SwiftUI

struct SongSectionView: View {
    let songs: [Song]
    let rows = Array(repeating: GridItem(.fixed(60)), count: 4)
    
    var body: some View {
        
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 15) {
                ForEach(songs) { song in
                    
                    NavigationLink {
                       SongDetailView(song: song)
                    } label: {
                        SongRowView(song: song)
                            .frame(width: 300)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding([.horizontal,.bottom])

            
            
            
            
            
            
            



        }
    }
}

struct SongSectionView_Previews: PreviewProvider {
    static var previews: some View {
        SongSectionView(songs: [Song.example()])
    }
}
