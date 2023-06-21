//
//  MovieListView.swift
//  ItunesApp
//
//  Created by MacBook Air on 12.06.2023.
//

import SwiftUI

struct MovieSearchView: View {
    
    
    @StateObject private var viewModel = MovieListViewModel()
    var body: some View {
        NavigationView {
            Group {
                if viewModel.searchTerm.isEmpty {
                    
                    SearchPlaceholderView(searchTerm: $viewModel.searchTerm)
                } else {
                    MovieListView(viewModel: viewModel)
                }
            }
            
            .searchable(text: $viewModel.searchTerm)
            .navigationTitle("Search Movies")
        }
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
