//
//  MovieTableViewCell.swift
//  MoviesApp
//
//  Created by Lucas Galvao on 16/01/23.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    static let identifier = "MovieTableViewCell"
    var category: MovieCategory?
    var tableCellViewModel: MovieTableViewCellViewModel = MovieTableViewCellViewModel()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Movies"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 130, height: 200)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.minimumLineSpacing = 15
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
//        collection.dataSource = self
//        collection.delegate = self
        collection.register(MovieCollectionCell.self, forCellWithReuseIdentifier: "Cell")
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
        self.selectionStyle = .none
        self.backgroundColor = .systemGray2
    }
    
    func configure(category: MovieCategory){
        self.titleLabel.text = category.rawValue
        self.category = category
    }
    
    func setConstraints(){
        self.addSubview(titleLabel)
        self.addSubview(collectionView)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 210)
        ])
    }
    
    public func collectionSettings(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource){
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MovieViewController: CollectionViewReloadDelegate {
    
    func collectionViewReloadData() {
        MovieTableViewCell().collectionView.reloadData()
    }
}

extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
//        self.tableCellViewModel.getCount(category: self.category ?? MovieCategory.TopRated)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? MovieCollectionCell
        
        cell?.configureCell(movie: Network.shared.dataBaseUpcoming[indexPath.row])
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     print("Algo")
    }
}
