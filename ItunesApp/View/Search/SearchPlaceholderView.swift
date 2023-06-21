//
//  SearchPlaceholderView.swift
//  ItunesApp
//
//  Created by MacBook Air on 12.06.2023.
//

import SwiftUI

struct SearchPlaceholderView: View {
    
    @Binding var searchTerm: String
    
    let suggestions: [String] = [ "beatles",
                                  "nirvana",
                                  "scorpions",
                                  "rammstein"
    ]
    var body: some View {
        VStack(spacing: 8) {
            Text("Trending")
                .font(.title)
            ForEach(suggestions, id: \.self) { name in
                Button {
                    searchTerm = name
                } label: {
                    Text(name)
                        .font(.title2)
                }
            }
        }
    }
}

struct SearchPlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPlaceholderView(searchTerm: .constant("John"))
    }
}
