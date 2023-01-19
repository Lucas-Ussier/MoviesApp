//
//  MovieViewModel.swift
//  MoviesApp
//
//  Created by Lucas Galvao on 19/01/23.
//

import Foundation

class MovieViewModel{
    
    let network = Network.shared
    
    func getMovieImagePath(category: MovieCategory, indexPath: IndexPath) -> String{
        switch category {
        case .Popular:
            return network.dataBasePopular[indexPath.row].posterPath
        case .TopRated:
            return network.dataBaseTopRated[indexPath.row].posterPath
        case .Upcoming:
            return network.dataBaseUpcoming[indexPath.row].posterPath
        case .NowPlaying:
            return network.dataBaseNowPlaying[indexPath.row].posterPath
        }
    }
    
    func getMovieId(category: MovieCategory, indexPath: IndexPath) -> Int{
        switch category {
        case .Popular:
            return network.dataBasePopular[indexPath.row].id
        case .TopRated:
            return network.dataBaseTopRated[indexPath.row].id
        case .Upcoming:
            return network.dataBaseUpcoming[indexPath.row].id
        case .NowPlaying:
            return network.dataBaseNowPlaying[indexPath.row].id
        }
    }
    
    func count(category: MovieCategory) -> Int{
        switch category {
        case .Popular:
            return network.dataBasePopular.count
        case .TopRated:
            return network.dataBaseTopRated.count
        case .Upcoming:
            return network.dataBaseUpcoming.count
        case .NowPlaying:
            return network.dataBaseNowPlaying.count
        }
    }
    
}
