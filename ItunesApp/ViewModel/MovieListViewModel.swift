//
//  MovieListViewModel.swift
//  ItunesApp
//
//  Created by MacBook Air on 12.06.2023.
//

import Foundation
import Combine

class MovieListViewModel: ObservableObject {
    @Published var searchTerm: String = ""
    @Published var movies: [Movie] = []
    @Published var state: FetchState = .good
    private var cancellables = Set<AnyCancellable>()
    
    let defaultLimits: Int = 50
    
    let apiService = APIService()
  
   
    init() {
        $searchTerm
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.clear()
                self?.fetchMovies(for: term)
            }
            .store(in: &cancellables)
    }
    
    func clear() {
        self.state = .good
        self.movies = []
    }
    
    func loadMore() {
        fetchMovies(for: searchTerm)
    }
    
    static func example() -> MovieListViewModel {
        let vm = MovieListViewModel()
        vm.movies = [Movie.example()]
        return vm
    }
    
    func fetchMovies(for searchTerm: String) {
        guard !searchTerm.isEmpty else {
            return
        }
        
        guard state == FetchState.good else {
            return
        }
        
        state = .isLoading
        
        apiService.fetchMovies(searchTerm: searchTerm) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    //result.results.forEach { self?.movies.append($0) }
                  
                    self?.movies = result.results
                    
                    if result.resultCount == self?.defaultLimits {
                        self?.state = .good
                    } else {
                        self?.state = .loadedAll
                    }
                    
                    print("Fetched movies: \(result.resultCount)")
                case .failure(let error):
                    self?.state = .error("Could not load: \(error.localizedDescription)")
                }
            }
        }
    }
}
