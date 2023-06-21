//
//  ContentView.swift
//  ItunesApp
//
//  Created by MacBook Air on 11.06.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            ALbumSearchView()
                .tabItem {
                    Label("Albums", systemImage: "music.note")
                }
            MovieSearchView()
                .tabItem {
                    Label("Movies", systemImage: "tv")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
