//
//  TMDBMovieRepository.swift
//  Examen_iOS
//
//  Created by Diego Vega Camacho on 10/10/23.
//

import Foundation

/// Enum representing various network-related errors.
enum NetworkError: Error {
    case noData
    case decodingError
    case urlError
}

/// Implementation of MovieRepository for fetching popular movies from TMDB API.
class TMDBMovieRepository: MovieRepository {
    func fetchPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?a17373f99eb64c6df481e8d40a633b44") else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "URL incorrecta"])
            completion(.failure(NetworkError.urlError))
            return
        }

        /// Create a request for the URL
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhMTczNzNmOTllYjY0YzZkZjQ4MWU4ZDQwYTYzM2I0NCIsInN1YiI6IjY1MjU3Y2EzMDcyMTY2NDViNmRhOGNlNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.MbTuG4nLef9QETb0liI5nuqaUitoAJDj3hgMXcK3o2A", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        /// Perform the URL session data task for fetching data
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                /// Decode the JSON response into MovieResponse and extract the movies
                let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(movieResponse.results))
            } catch {
                completion(.failure(NetworkError.decodingError))
            }
        }.resume()
    }
}
