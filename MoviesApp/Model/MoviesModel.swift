//
//  MoviesModel.swift
//  MoviesApp
//
//  Created by Lucas Galvao on 14/10/22.
//

import Foundation

struct Movies {
    static var popularMovies: [MoviesData] = []
    static var movie: MovieDetails?
    static var movieDetails: MovieDetails?
    static var currentMovieId: Int?
}

struct Results: Codable {
    var results: [MoviesData]
}

struct MoviesData: Codable {
   
    var poster_path: String?
    var adult: Bool?
    var overview: String?
    var release_date: String?
    var genre_ids: [Int]?
    var id: Int?
    var original_title: String?
    var original_language: String?
    var title: String?
    var backdrop_path: String?
    var popularity: Float?
    var vote_count: Int?
    var video: Bool?
    var vote_average: Float?
}

struct MovieDetails: Codable {
    var adult: Bool?
    var backdrop_path: String?
    var budget: Int?
    var genres: [Genres]
    var homepage: String?
    var id: Int?
    var imdb_id: String?
    var original_language: String?
    var original_title: String?
    var overview: String
    var popularity: Float?
    var poster_path: String?
    var production_companies: [ProductionCompanies]?
    var production_countries: [ProductionCountries]?
    var release_date: String
    var revenue: Int?
    var runtime: Int
    var spoken_languages: [SpokenLanguages]?
    var status: String?
    var tagline: String?
    var title: String
    var video: Bool?
    var vote_average: Float?
    var vote_count: Int?
}

struct Genres: Codable {
    var id: Int?
    var name: String
}

struct ProductionCompanies: Codable {
    var name: String?
    var id: Int?
    var logo_path: String?
    var origin_country: String?
}

struct ProductionCountries: Codable {
    var iso_639_1: String?
    var name: String?
}

struct SpokenLanguages: Codable {
    var iso_639_1: String?
    var name: String?
}

struct Credits: Codable{
    var id: Int?
    var cast: [Cast]
}

struct Cast: Codable {
    var id: Int?
    var character: String?
    var creditId: String?
    var name: String?
    var profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case creditId = "credit_id"
        case character = "character"
        case name = "name"
        case profilePath = "profile_path"
    }
}

