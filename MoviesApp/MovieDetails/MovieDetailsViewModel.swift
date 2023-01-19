//
//  MovieDetailsViewModel.swift
//  MoviesApp
//
//  Created by Lucas Galvao on 14/10/22.
//

import UIKit

class MovieDetailsViewModel {
    
    var network = Network.shared
    
    var castCount: Int {
        return network.castDataBase.count
    }
    
    func getCastImages(at index: Int, imageView: UIImageView?) {
        
        guard let path = network.castDataBase[index].profilePath else {return}
        
        let string = "\(network.imageURL)\(path)"
        guard let url = URL(string: string) else {return}
        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let imageData = data{
                    DispatchQueue.main.async {
                        imageView?.image = UIImage(data: imageData)
                    }
                }
            }.resume()
        }
    }
    
    func getCast(at index: Int) -> Cast {
        
        let character = network.castDataBase[index].character
        let name = network.castDataBase[index].name
        
        
        return Cast(character: character, name: name)
    }
    
    func getImage(at index: Int, imageView: UIImageView?, category: MovieCategory) {
        
        var chosenId = 0
        
        if category == .Popular{
            for i in 0...network.dataBasePopular.count-1 {
                if network.dataBasePopular[i].id == index{
                    chosenId = i
                    break
                }
            }
        }
            
        if category == .TopRated{
            for i in 0...network.dataBaseTopRated.count-1 {
                if network.dataBaseTopRated[i].id == index{
                    chosenId = i
                    break
                }
            }
        }
        
        if category == .Upcoming{
            for i in 0...network.dataBaseUpcoming.count-1 {
                if network.dataBaseUpcoming[i].id == index{
                    chosenId = i
                    break
                }
            }
        }
              
        if category == .NowPlaying{
            for i in 0...network.dataBaseNowPlaying.count-1 {
                if network.dataBaseNowPlaying[i].id == index{
                    chosenId = i
                    break
                }
            }
        }
        
        
        var teste = ""
        
        if category == .Popular{
            guard let path = network.dataBasePopular[chosenId].backdropPath else {return}
            teste = path
        }
            
        if category == .TopRated{
            guard let path = network.dataBaseTopRated[chosenId].backdropPath else {return}
            teste = path
        }
        
        if category == .Upcoming{
            guard let path = network.dataBaseUpcoming[chosenId].backdropPath else {return}
            teste = path
        }
              
        if category == .NowPlaying{
            guard let path = network.dataBaseNowPlaying[chosenId].backdropPath else {return}
            teste = path
        }
        
        let string = "\(network.imageURL)\(teste)"
        guard let url = URL(string: string) else {return}
        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let imageData = data{
                    DispatchQueue.main.async {
                        imageView?.image = UIImage(data: imageData)
                    }
                }
            }.resume()
        }
    }
    
    func getMovieDetails() -> MovieDetails {
        
        let movie = network.detailsDataBase
        
        let overview = movie.overview
        let date = movie.release_date
        let chars = date.map({ Character(extendedGraphemeClusterLiteral: $0)})
        let year = "\(chars[0])\(chars[1])\(chars[2])\(chars[3])"
        let title = movie.title
        let duration = movie.runtime
        let genres = movie.genres
        var genresString = ""
        
        for i in 0...genres.count-1{
            let genre = genres[i].name
            if i == genres.count-1{
                genresString += "\(genre)."
            }else{
                genresString += "\(genre), "
            }
        }
        
        return MovieDetails(genres: [Genres(name: genresString)], overview: overview,release_date: year, runtime: duration, title: title)
    }
}
