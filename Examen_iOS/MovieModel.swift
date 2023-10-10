//
//  MovieModel.swift
//  Examen_iOS
//
//  Created by Diego Vega Camacho on 10/10/23.
//

import Foundation

struct Movie: Codable {
    var id: Int
    var title: String
    var poster_path: String?
}

struct MovieResponse: Codable {
    var results: [Movie]
}
