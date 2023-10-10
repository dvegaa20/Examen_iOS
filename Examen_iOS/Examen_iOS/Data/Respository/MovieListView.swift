//
//  MovieListView.swift
//  Examen_iOS
//
//  Created by Diego Vega Camacho on 10/10/23.
//

import Foundation
import SwiftUI

/// It's the main view of the project, here the movies are displayed in a Netflix type style main page
/// where the images and the names of the movies are shown.
struct MovieListView: View {
    
    /// Declaration of MovieListViewModel to forward the loadData() function that makes the fetch of the popular movies
    @StateObject private var viewModel = MovieListViewModel(movieRepository: TMDBMovieRepository())

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                    ForEach(viewModel.movies, id: \.id) { movie in
                        VStack {
                            //// MOVIE IMAGE
                            if let posterPath = movie.poster_path,
                               let url = URL(string: "https://image.tmdb.org/t/p/original\(posterPath)") {
                                AsyncImage(url: url) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(height: 200)
                                } placeholder: {
                                    Color.gray
                                }
                                .cornerRadius(10)
                            }

                            //// MOVIE TITTLE
                            Text(movie.title)
                                .padding(.top, 8)
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                                .underline()
                                .padding(.horizontal, 8)
                        }
                    }
                }
                .padding(16)
            }
            .navigationBarTitle("Películas Populares")
        }
        .onAppear(perform: viewModel.loadData)
    }
}

