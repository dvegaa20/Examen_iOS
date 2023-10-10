//
//  MovieViewModel.swift
//  Examen_iOS
//
//  Created by Diego Vega Camacho on 10/10/23.
//

import Foundation

class MovieListViewModel: ObservableObject {
    @Published var movies = [Movie]()
    
    private let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
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

