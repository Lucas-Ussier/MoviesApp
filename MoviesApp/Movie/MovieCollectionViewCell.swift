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
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .systemPurple
        return view
    }()
    
    private lazy var movieTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Filme"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.addSubview(moviePosterImageView)
        self.addSubview(movieTitleLabel)
        self.setupConstraints()
    }
    
    func setupCell(url: String, title: String){
        self.setImage(from: url, imageView: self.moviePosterImageView)
        self.movieTitleLabel.text = title
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            moviePosterImageView.topAnchor.constraint(equalTo: self.topAnchor),
            moviePosterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            moviePosterImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            moviePosterImageView.bottomAnchor.constraint(equalTo: self.movieTitleLabel.topAnchor, constant: -10),
            
            movieTitleLabel.leadingAnchor.constraint(equalTo: moviePosterImageView.leadingAnchor),
            movieTitleLabel.trailingAnchor.constraint(equalTo: moviePosterImageView.trailingAnchor),
            movieTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
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
