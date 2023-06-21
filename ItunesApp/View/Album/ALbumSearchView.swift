//
//  ALbumSearchView.swift
//  ItunesApp
//
//  Created by MacBook Air on 11.06.2023.
//

import SwiftUI

struct ALbumSearchView: View {
    @StateObject private var viewModel = AlbumListViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.searchTerm.isEmpty {
                    SearchPlaceholderView(searchTerm: $viewModel.searchTerm)
                } else {
                    AlbumListView(viewModel: viewModel)
                }
            }
            
            .searchable(text: $viewModel.searchTerm)
            .navigationTitle("Search Albums")
        }
    }
}



struct ALbumSearchView_Previews: PreviewProvider {
    static var previews: some View {
        ALbumSearchView()
    }
}
