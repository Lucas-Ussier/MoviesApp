//
//  Network.swift
//  MoviesApp
//
//  Created by Lucas Galvao on 14/10/22.
//


import UIKit

enum MovieCategory: String{
    case Popular = "popular"
    case TopRated = "top_rated"
    case Upcoming = "upcoming"
    case NowPlaying = "now_playing"
}

protocol CollectionViewReloadDelegate{
    func collectionViewReloadData(category: MovieCategory)
}

protocol DetailsCollectionViewReloadDelegate{
    func collectionViewReloadData()
}

public class Network: UIImageView{
    
    static let shared = Network()
    var delegate: CollectionViewReloadDelegate?
    var detailsDelegate: DetailsCollectionViewReloadDelegate?
    
    let imageURL: String = "https://image.tmdb.org/t/p/original"
    var dataBase = [MoviesData]()
    var dataBasePopular = [MoviesData]()
    var dataBaseTopRated = [MoviesData]()
    var dataBaseUpcoming = [MoviesData]()
    var dataBaseNowPlaying = [MoviesData]()
    var castDataBase = [Cast]()
    var detailsDataBase = MovieDetails(genres: [Genres(name: "")], overview: "", release_date: "0000", runtime: 0, title: "")

    
    func getMovie(category: MovieCategory) {
        
        let apiKey = "6960008c62a943211888e16078f6f5b1"
        
        if let tmdbAPIBaseURL = URL(string: "https://api.themoviedb.org/3/movie/\(category.rawValue)?api_key=\(apiKey)&language=pt-BR") {
            
            URLSession.shared.dataTask(with: tmdbAPIBaseURL) { data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(Results.self, from: data)
                        DispatchQueue.main.async {
                            switch category {
                            case .Popular:
                                self.dataBasePopular = res.results
                                self.delegate?.collectionViewReloadData(category: .Popular)
                            case .TopRated:
                                self.dataBaseTopRated = res.results
                                self.delegate?.collectionViewReloadData(category: .TopRated)
                            case .Upcoming:
                                self.dataBaseUpcoming = res.results
                                self.delegate?.collectionViewReloadData(category: .Upcoming)
                            case .NowPlaying:
                                self.dataBaseNowPlaying = res.results
                                self.delegate?.collectionViewReloadData(category: .NowPlaying)
                            }
                            
                        }
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
    }

    
    func getMovieDetails(id: Int) {
        
        let apiKey = "6960008c62a943211888e16078f6f5b1"
        
        if let tmdbAPIBaseURL = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)&language=pt-BR") {
            
            URLSession.shared.dataTask(with: tmdbAPIBaseURL) { data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(MovieDetails.self, from: data)
                        DispatchQueue.main.async {
                            self.detailsDataBase = res
                        }
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    func getMovieCast(id: Int) {
        
        let apiKey = "6960008c62a943211888e16078f6f5b1"
        
        if let tmdbAPIBaseURL = URL(string: "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=\(apiKey)&language=pt-BR") {
            
            URLSession.shared.dataTask(with: tmdbAPIBaseURL) { data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(Credits.self, from: data)
                        DispatchQueue.main.async {
                            self.castDataBase = res.cast
                            self.detailsDelegate?.collectionViewReloadData()
                        }
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
    }
}
