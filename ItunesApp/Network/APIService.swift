//
//  APIService.swift
//  ItunesApp
//
//  Created by MacBook Air on 11.06.2023.
//

import Foundation

class APIService {
    
    
    func fetchAlbums(searchTerm: String, page: Int, limit: Int, completion: @escaping (Result<AlbumResult, APIError>)-> Void) {
        let url = createUrl(for: searchTerm, type: .album, page: page, limit: limit)
        fetch(type: AlbumResult.self, url: url, completion: completion)
    }
    
    func fetchAlbum(for albumID: Int, completion: @escaping (Result<AlbumResult, APIError>)-> Void) {
        let url = createURL(for: albumID, type: .album)
        fetch(type: AlbumResult.self, url: url, completion: completion)
    }
    
    func fetchSongs(for albumId: Int, completion: @escaping (Result<SongResult, APIError>) -> Void) {
        let url = createURL(for: albumId, type: .song)
        fetch(type: SongResult.self, url: url, completion: completion)
    }
    func fetchSongs(searchTerm: String, page: Int, limit: Int, completion: @escaping (Result<SongResult, APIError>)-> Void){
        let url = createUrl(for: searchTerm, type: .song, page: page, limit: limit)
        fetch(type: SongResult.self, url: url, completion: completion)
    }
    
    func fetchMovies(searchTerm: String, completion: @escaping (Result<MovieResult, APIError>)-> Void){
        let url = createUrl(for: searchTerm, type: .movie, page: nil, limit: nil)
        fetch(type: MovieResult.self, url: url, completion: completion)
    }
    
    
    func fetch<T: Decodable>(type: T.Type,url: URL?, completion: @escaping (Result<T, APIError>)-> Void) {
        
        guard let url = url else {
            let error = APIError.badURL
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error as? URLError,
               let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.urlSession(error)))
                completion(Result.failure(APIError.badResponse(response.statusCode)))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(type, from: data)
                    completion(.success(result))
                } catch let error {
                    completion(Result.failure(APIError.decoding(error as! DecodingError)))
                }
            }
        }
        .resume()
    }
    
    func createUrl(for searchTerm: String, type: EntityType, page: Int?, limit: Int?) -> URL? {
        //  https://itunes.apple.com/search?term=jack+johnson&entity=album&limit=5&pffset=10
        
        let baseUrl = "https://itunes.apple.com/search"
        
        
        
        var queryItems = [URLQueryItem(name: "term", value: searchTerm),
                          URLQueryItem(name: "entity", value: type.rawValue)
        ]
        
        if let page = page, let limit = limit {
            let offset = page * limit
            queryItems.append(URLQueryItem(name: "limit", value: "\(limit)"))
            queryItems.append(URLQueryItem(name: "offset", value: "\(offset)"))
        }
        
        var components = URLComponents(string: baseUrl)
        components?.queryItems = queryItems
        return components?.url
    }
    
    func createURL(for id: Int, type: EntityType) -> URL? {
        let baseURL = "https://itunes.apple.com/lookup"
        
        var queryItems = [
            URLQueryItem(name: "id", value: String(id)),
            URLQueryItem(name: "entity", value: type.rawValue)
        ]
        
        var components = URLComponents(string: baseURL)
        components?.queryItems = queryItems
        return components?.url
    }
}

