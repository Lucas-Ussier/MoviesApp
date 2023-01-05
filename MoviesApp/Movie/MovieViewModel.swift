//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by Lucas Galvao on 14/10/22.
//

import UIKit

class MovieViewModel{
    
    private let network = Network.shared
    
    var count: Int {
        return network.dataBaseTopRated.count
    }
    
    func getImage(at indexPath: IndexPath, imageView: UIImageView?, titleLabel: UILabel) {
        
        if titleLabel.text == "Popular Movies"{
            guard let path = network.dataBasePopular[indexPath.row].poster_path else { return }
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
        }else{
            guard let path = network.dataBaseTopRated[indexPath.row].poster_path else { return }
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
    }
    
    func getDate(at indexPath: IndexPath, titleLabel: UILabel) -> String {
        
        if titleLabel.text == "Popular Movies" {
            guard let datePopular = network.dataBasePopular[indexPath.row].release_date else {return "No date avaliable."}
            return datePopular
        } else {
            guard let date = network.dataBaseTopRated[indexPath.row].release_date else {return "No date avaliable."}
            
            return date
        }
    }
    
    func getTitle(at indexPath: IndexPath, titleLabel: UILabel) -> String {
        
        if titleLabel.text == "Popular Movies" {
            guard let titlePopular = network.dataBasePopular[indexPath.row].title else {return "No title avaliable."}
            return titlePopular
        } else {
            guard let title = network.dataBaseTopRated[indexPath.row].title else {return "No title avaliable."}
            return title
        }
    }
}
