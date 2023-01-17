//
//  SeriesCollectionViewCell.swift
//  MoviesApp
//
//  Created by user217584 on 17/01/23.
//

import Foundation
import UIKit

class SeriesCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UIImage
    lazy var serieImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    //MARK: - Label
    lazy var nameSerieLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.adjustsFontSizeToFitWidth = true
        lb.numberOfLines = 0
        lb.font = UIFont.systemFont(ofSize: 12)
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "Nome da Serie"
        return lb
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondaryLabel
        contentView.addSubview(serieImage)
        contentView.addSubview(nameSerieLabel)
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Constraints
    private func configConstraints() {
        
        NSLayoutConstraint.activate([
            serieImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            serieImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            serieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            serieImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            nameSerieLabel.topAnchor.constraint(equalTo: serieImage.bottomAnchor, constant: 10),
            nameSerieLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            nameSerieLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
}
