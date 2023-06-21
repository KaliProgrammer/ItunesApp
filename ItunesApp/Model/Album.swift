//
//  Album.swift
//  ItunesApp
//
//  Created by MacBook Air on 11.06.2023.
//

import Foundation

// MARK: - Album
struct AlbumResult: Codable {
    let resultCount: Int
    let results: [Album]
}

// MARK: - Result
struct Album: Codable, Identifiable {
    let id = UUID().uuidString
    let wrapperType, collectionType: String?
    let artistID, collectionID: Int?
    let amgArtistID: Int?
    let artistName, collectionName, collectionCensoredName: String?
    let artistViewURL: String?
    let collectionViewURL: String?
    let artworkUrl60, artworkUrl100: String?
    let collectionPrice: Double?
    let collectionExplicitness: String?
    let trackCount: Int?
    let copyright, country, currency: String?
    let releaseDate: String?
    let primaryGenreName: String?

    enum CodingKeys: String, CodingKey {
        case wrapperType, collectionType
        case artistID = "artistId"
        case collectionID = "collectionId"
        case amgArtistID = "amgArtistId"
        case artistName, collectionName, collectionCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case artworkUrl60, artworkUrl100, collectionPrice, collectionExplicitness, trackCount, copyright, country, currency, releaseDate, primaryGenreName
    }
    
    static func example() -> Album {
        
        Album(wrapperType: "collection", collectionType: "Album", artistID: 2, collectionID: 1, amgArtistID: 3,
              artistName: "Jack Johnson & Friends",
              collectionName: "Best of Kokua Festival (A Benefit for the Kokua Hawaii Foundation)", collectionCensoredName: "",
              artistViewURL: nil, collectionViewURL: "",
              artworkUrl60: "https://is2-ssl.mzstatic.com/image/thumb/Music114/v4/43/d0/ba/43d0ba6b-6470-ad2d-0c84-171c1daea838/12UMGIM10699.rgb.jpg/60x60bb.jpg",
              artworkUrl100: "https://is2-ssl.mzstatic.com/image/thumb/Music114/v4/43/d0/ba/43d0ba6b-6470-ad2d-0c84-171c1daea838/12UMGIM10699.rgb.jpg/100x100bb.jpg",
              collectionPrice: 8.99, collectionExplicitness: "", trackCount: 15, copyright: nil, country: "USA", currency: "USD", releaseDate: "2012-01-01T08:00:00Z", primaryGenreName: "Rock")
        
    }
}
