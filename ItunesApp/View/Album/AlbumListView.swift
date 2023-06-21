//
//  AlbumListView.swift
//  ItunesApp
//
//  Created by MacBook Air on 11.06.2023.
//

import SwiftUI

struct AlbumListView: View {
    
    @ObservedObject var viewModel: AlbumListViewModel
    
    var body: some View {
       
            List {
                ForEach(viewModel.albums) { album in
                    NavigationLink {
                        AlbumDetailView(album: album)
                    } label: {
                        AlbumRowView(album: album)
                    } 
                }
                
                switch viewModel.state {
                case .good:
                    Color.clear
                    .onAppear {
                        viewModel.loadMore()
                    }
                case .isLoading:
                    ProgressView()
                        .progressViewStyle(.circular)
                        .frame(maxWidth: .infinity)
                case .loadedAll:
                    EmptyView()
                case .error(let message):
                    Text(message)
                        .foregroundColor(.pink)
                }
            }
        .listStyle(.plain)
        }
}



struct AlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AlbumListView(viewModel: AlbumListViewModel.example())
        }
    }
}
