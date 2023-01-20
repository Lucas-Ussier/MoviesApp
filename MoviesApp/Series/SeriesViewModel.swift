//
//  SeriesViewModel.swift
//  MoviesApp
//
//  Created by user217584 on 20/01/23.
//

import Foundation

class SeriesViewModel {
    
    let network = Network.shared
    
    func getSerieImagePath(category: SeriesCategory, indexPath: IndexPath) -> String{
        switch category {
        case .Popular:
            return network.dataBaseSeriesPopular[indexPath.row].posterPath
        case .TopRated:
            return network.dataBaseSeriesTopRated[indexPath.row].posterPath
        case .TVOnTheAir:
            return network.dataBaseTVOnTheAir[indexPath.row].posterPath
        case .TVAiringToday:
            return network.dataBaseTVAiringToday[indexPath.row].posterPath
        }
    }
    
    func getSeriesId(category: SeriesCategory, indexPath: IndexPath) -> Int{
        switch category {
        case .Popular:
            return network.dataBaseSeriesPopular[indexPath.row].id
        case .TopRated:
            return network.dataBaseSeriesTopRated[indexPath.row].id
        case .TVOnTheAir:
            return network.dataBaseTVOnTheAir[indexPath.row].id
        case .TVAiringToday:
            return network.dataBaseTVAiringToday[indexPath.row].id
        }
    }
    
    func count(category: SeriesCategory) -> Int{
        switch category {
        case .Popular:
            return network.dataBaseSeriesPopular.count
        case .TopRated:
            return network.dataBaseSeriesTopRated.count
        case .TVOnTheAir:
            return network.dataBaseTVOnTheAir.count
        case .TVAiringToday:
            return network.dataBaseTVAiringToday.count
        }
    }
}
