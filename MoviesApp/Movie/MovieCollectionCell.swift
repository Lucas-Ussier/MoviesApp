//
//  HomeCollectionCell.swift
//  MoviesApp
//
//  Created by Lucas Galvao on 14/10/22.
//

import UIKit

class MovieCollectionCell: UICollectionViewCell {
    
    let movieImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .black
        return image
    }()
    
    let dateBackView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "DD/MM/YY"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameMovieLabel: UILabel = {
        let label = UILabel()
        label.text = "Movie Name"
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: .zero)
        contentView.addSubview(movieImage)
        contentView.addSubview(dateBackView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(nameMovieLabel)
        
        creatingConstraints()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(movie: MoviesData){
        self.dateLabel.text = movie.releaseDate
        self.nameMovieLabel.text = movie.title
        self.setImage(from: movie.posterPath, imageView: self.movieImage)
        
    }
    
    func creatingConstraints() {
        
        movieImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        movieImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        movieImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        movieImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        movieImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        dateBackView.widthAnchor.constraint(equalToConstant: 85).isActive = true
        dateBackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        dateBackView.centerXAnchor.constraint(equalTo: movieImage.centerXAnchor).isActive = true
        dateBackView.bottomAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: -10).isActive = true
        
        dateLabel.centerXAnchor.constraint(equalTo: dateBackView.centerXAnchor).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: dateBackView.centerYAnchor).isActive = true
        
        nameMovieLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        nameMovieLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        nameMovieLabel.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 10).isActive = true
    }
}

extension MovieCollectionCell {
    
    func setImage(from url: String?, imageView: UIImageView) {
        guard let url else {return}
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
