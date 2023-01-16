//
//  MovieTableViewCellViewModel.swift
//  MoviesApp
//
//  Created by Lucas Galvao on 16/01/23.
//

import Foundation

class MovieTableViewCellViewModel{
    
    private let network = Network.shared
    func getCount(category: MovieCategory) -> Int{
        switch category {
        case .Popular:
            return self.network.dataBasePopular.count
        case .TopRated:
            return self.network.dataBaseTopRated.count
        case .Upcoming:
            return self.network.dataBaseUpcoming.count
        case .NowPlaying:
            return self.network.dataBaseNowPlaying.count
        case .Latest:
            return self.network.dataBaseLatest.count
        }
    }
}
