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
    case Latest = "latest"
}

protocol CollectionViewReloadDelegate{
    func collectionViewReloadData()
}

protocol DetailsCollectionViewReloadDelegate{
    func collectionViewReloadData()
}

public class Network {
    
    static let shared = Network()
    var delegate: CollectionViewReloadDelegate?
    var detailsDelegate: DetailsCollectionViewReloadDelegate?
    
    let imageURL: String = "https://image.tmdb.org/t/p/original"
    var dataBase = [MoviesData]()
    var dataBasePopular = [MoviesData]()
    var dataBaseTopRated = [MoviesData]()
    var dataBaseUpcoming = [MoviesData]()
    var dataBaseNowPlaying = [MoviesData]()
    var dataBaseLatest = [MoviesData]()
    var castDataBase = [Cast]()
    var detailsDataBase = MovieDetails(genres: [Genres(name: "")], overview: "", release_date: "0000", runtime: 0, title: "")
    
    func getPopularMovie() {
        
        let apiKey = "6960008c62a943211888e16078f6f5b1"
        
        if let tmdbAPIBaseURL = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)") {
            
            URLSession.shared.dataTask(with: tmdbAPIBaseURL) { data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(Results.self, from: data)
                        DispatchQueue.main.async {
                            self.dataBasePopular = res.results
                            self.delegate?.collectionViewReloadData()
                        }
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    func getMovie(category: MovieCategory) {
        
        let apiKey = "6960008c62a943211888e16078f6f5b1"
        
        if let tmdbAPIBaseURL = URL(string: "https://api.themoviedb.org/3/movie/\(category.rawValue)?api_key=\(apiKey)") {
            
            URLSession.shared.dataTask(with: tmdbAPIBaseURL) { data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(Results.self, from: data)
                        DispatchQueue.main.async {
                            switch category {
                            case .Popular:
                                self.dataBasePopular = res.results
                                self.delegate?.collectionViewReloadData()
                            case .TopRated:
                                self.dataBaseTopRated = res.results
                                self.delegate?.collectionViewReloadData()
                            case .Upcoming:
                                self.dataBaseUpcoming = res.results
                                self.delegate?.collectionViewReloadData()
                            case .NowPlaying:
                                self.dataBaseNowPlaying = res.results
                                self.delegate?.collectionViewReloadData()
                            case .Latest:
                                self.dataBaseLatest = res.results
                                self.delegate?.collectionViewReloadData()
                            }
                            
                        }
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    func getUpcomingMovie() {
        
        let apiKey = "6960008c62a943211888e16078f6f5b1"
        
        if let tmdbAPIBaseURL = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)") {
            
            URLSession.shared.dataTask(with: tmdbAPIBaseURL) { data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(Results.self, from: data)
                        DispatchQueue.main.async {
                            self.dataBase = res.results
                            self.delegate?.collectionViewReloadData()
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
        
        if let tmdbAPIBaseURL = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)") {
            
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
        
        if let tmdbAPIBaseURL = URL(string: "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=\(apiKey)") {
            
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
