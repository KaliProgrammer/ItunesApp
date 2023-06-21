//
//  SongsForAlbumListView.swift
//  ItunesApp
//
//  Created by MacBook Air on 17.06.2023.
//

import SwiftUI

struct SongsForAlbumListView: View {
    
    @ObservedObject var viewModel: SongsForAlbumListViewModel
    let selectedSong: Song?
    
    
    var body: some View {
        
        
        ScrollViewReader { proxy in
            
            
            
            ScrollView {
                
                if viewModel.state == .isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                    
                } else if viewModel.songs.count > 0 {
                    
                    Group {
                        if #available(iOS 16.0, *) {
                            SongGridView(songs: viewModel.songs, selectedSong: selectedSong)
                            
                        } else {
                            SongStackView(songs: viewModel.songs, selectedSong: selectedSong)
                        }
                    }
                    .onAppear {
                        proxy.scrollTo(selectedSong?.trackNumber, anchor: .center)
                    }
                }
            }
        }
    }
}


@available(iOS 16.0, *)
struct SongGridView: View {
    
    let songs: [Song]
    let selectedSong: Song?
    
    var body: some View {
        Grid(horizontalSpacing: 20) {
            
            ForEach(songs) { song in
                GridRow {
                    Text(String(song.trackNumber ?? 0))
                        .font(.footnote)
                        .gridColumnAlignment(.trailing)
                    
                    Text(song.trackName ?? "")
                        .gridColumnAlignment(.leading)
                    Spacer()
                    Text(formattedDuration(time: song.trackTimeMillis ?? 0))
                        .font(.footnote)
                    
                    
                    BuySongButtonView(urlString: song.previewURL, price: song.trackPrice, currency: song.currency)
                        .padding(.trailing)
                    
                }
                .foregroundColor(song.trackName == selectedSong?.trackName ? Color.accentColor : Color(.label))
                .id(song.trackNumber)
                
                Divider()
            }
        }
    }
}

fileprivate func formattedDuration(time: Int) -> String {
    
    let timeInSeconds = time / 1000
    let interval = TimeInterval(timeInSeconds)
    let formatter = DateComponentsFormatter()
    formatter.zeroFormattingBehavior = .pad
    formatter.allowedUnits = [.minute, .second]
    formatter.unitsStyle = .positional
    
    return formatter.string(from: interval) ?? ""
    
}

struct SongStackView: View {
    let songs: [Song]
    let selectedSong: Song?
    
    var body: some View {
        VStack {
            
            ForEach(songs) { song in
                HStack {
                    Text(String(song.trackNumber ?? 0))
                        .font(.footnote)
                        .frame(width: 25, alignment: .trailing)
                    
                    Text(song.trackName ?? "")
                    
                    Spacer()
                    Text(formattedDuration(time: song.trackTimeMillis ?? 0))
                        .font(.footnote)
                    
                    
                    BuySongButtonView(urlString: song.previewURL, price: song.trackPrice, currency: song.currency)
                    
                }
                .foregroundColor(song.trackName == selectedSong?.trackName ? Color.accentColor : Color(.label))
                .id(song.trackNumber)
                
                Divider()
            }
        }
        .padding([.vertical, .leading])
    }
    
    
}

struct SongsForAlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        SongsForAlbumListView(viewModel: SongsForAlbumListViewModel.example(), selectedSong: nil)
    }
}

