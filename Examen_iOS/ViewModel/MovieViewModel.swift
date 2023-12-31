//
//  MovieViewModel.swift
//  Examen_iOS
//
//  Created by Diego Vega Camacho on 10/10/23.
//

import Foundation

/// Represents the list of the Movies form the API
class MovieListViewModel: ObservableObject {
    @Published var movies = [Movie]()
    
    private let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    /// Loads the data from the API
    ///
    /// - Doesn't recieve any parameters, just makes the call to the repository, updates the movies if the movieResponse
    ///  was succesfull and manages the error of a failure in the fetch
    func loadData() {
        movieRepository.fetchPopularMovies { result in
            switch result {
            case .success(let movieResponse):
                DispatchQueue.main.async {
                    self.movies = movieResponse
                }
            case .failure(let error):
                print("Error al obtener películas populares: \(error.localizedDescription)")
            }
        }
    }
}

