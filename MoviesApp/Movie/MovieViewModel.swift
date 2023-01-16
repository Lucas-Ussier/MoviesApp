//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by Lucas Galvao on 14/10/22.
//

import UIKit

class MovieViewModel{
    
    private let network = Network.shared
    let movieCategoriesArray = [
        MovieCategory.Upcoming,
        MovieCategory.Latest,
        MovieCategory.NowPlaying,
        MovieCategory.TopRated,
        MovieCategory.Popular,
    ]
    
    var countCategory: Int {
        return movieCategoriesArray.count
    }
    
    func getMoviewCategory(indexPath: IndexPath) -> MovieCategory{
        return self.movieCategoriesArray[indexPath.row]
    }
  
//    func getDate(at indexPath: IndexPath, category: MovieCategory) -> String {
//        switch category {
//        case .Popular:
//            guard let date = network.dataBasePopular[indexPath.row].release_date else {return "No date avaliable."}
//            return date
//        case .TopRated:
//            guard let date = network.dataBaseTopRated[indexPath.row].release_date else {return "No date avaliable."}
//            return date
//        case .Upcoming:
//            guard let date = network.dataBaseUpcoming[indexPath.row].release_date else {return "No date avaliable."}
//            return date
//        case .NowPlaying:
//            guard let date = network.dataBaseNowPlaying[indexPath.row].release_date else {return "No date avaliable."}
//            return date
//        case .Latest:
//            guard let date = network.dataBaseLatest[indexPath.row].release_date else {return "No date avaliable."}
//            return date
//        }
//    }
//
//    func getTitle(at indexPath: IndexPath, category: MovieCategory) -> String {
//
//        switch category {
//        case .Popular:
//            guard let title = self.network.dataBasePopular[indexPath.row].title else {return "Título não encontrado"}
//            return title
//        case .TopRated:
//            guard let title = self.network.dataBaseTopRated[indexPath.row].title else {return "Título não encontrado"}
//            return title
//        case .Upcoming:
//            guard let title = self.network.dataBaseUpcoming[indexPath.row].title else {return "Título não encontrado"}
//            return title
//        case .NowPlaying:
//            guard let title = self.network.dataBaseNowPlaying[indexPath.row].title else {return "Título não encontrado"}
//            return title
//        case .Latest:
//            guard let title = self.network.dataBaseLatest[indexPath.row].title else {return "Título não encontrado"}
//            return title
//        }
//
//    }
}
