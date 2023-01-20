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
        image.contentMode = .scaleToFill
        return image
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondaryLabel
        contentView.addSubview(serieImage)
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(url: String){
        self.setImage(from: url, imageView: self.serieImage)
    }
    
    //MARK: - Constraints
    private func configConstraints() {
        
        NSLayoutConstraint.activate([
            serieImage.topAnchor.constraint(equalTo: self.topAnchor),
            serieImage.widthAnchor.constraint(equalTo: self.widthAnchor),
            serieImage.heightAnchor.constraint(equalTo: self.heightAnchor),
        ])
    }
}

extension SeriesCollectionViewCell {
    
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
