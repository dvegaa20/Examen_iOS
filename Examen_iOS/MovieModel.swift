//
//  MovieModel.swift
//  Examen_iOS
//
//  Created by Diego Vega Camacho on 10/10/23.
//

import Foundation

/// Data struct that represents a Movie
///
/// Note: The names of the properties inside this structure have to match 
/// the API's names in order to fetch in a correct way the information
struct Movie: Codable, Identifiable {
    var id: Int
    var title: String
    var poster_path: String?
    var overview: String?
}

/// Data struct that represents the result of the data inside a Movie type array
struct MovieResponse: Codable {
    var results: [Movie]
}
