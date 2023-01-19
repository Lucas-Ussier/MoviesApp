//
//  MovieCollectionViewCell.swift
//  MoviesApp
//
//  Created by Lucas Galvao on 17/01/23.
//

import Foundation
import UIKit

class MovieCollectionViewCell: UICollectionViewCell{
    static let identifier = "MovieCollectionViewCell"
    
    private lazy var moviePosterImageView: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .red
        self.addSubview(moviePosterImageView)
        self.setupConstraints()
    }
    
    func setupCell(url: String){
        self.setImage(from: url, imageView: self.moviePosterImageView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            moviePosterImageView.topAnchor.constraint(equalTo: self.topAnchor),
            moviePosterImageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            moviePosterImageView.heightAnchor.constraint(equalTo: self.heightAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension MovieCollectionViewCell {
    
    func setImage(from url: String, imageView: UIImageView) {
        guard let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(url)") else {return}
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else {return}
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
    }
}
