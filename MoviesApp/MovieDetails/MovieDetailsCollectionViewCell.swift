//
//  MovieDetailsCollectionViewCell.swift
//  MoviesApp
//
//  Created by Lucas Galvao on 14/10/22.
//

import UIKit

class MovieDetailsCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UIImage
    lazy var movieImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    //MARK: - Label
    lazy var nameImageLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.adjustsFontSizeToFitWidth = true
        lb.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        lb.numberOfLines = 0
        lb.font = UIFont.systemFont(ofSize: 12)
        lb.textColor = .white
        lb.textAlignment = .left
        return lb
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondaryLabel
        contentView.addSubview(movieImage)
        contentView.addSubview(nameImageLabel)
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Constraints
    private func configConstraints() {
        
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            nameImageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nameImageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            nameImageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
}
