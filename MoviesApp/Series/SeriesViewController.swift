//
//  SeriesViewController.swift
//  MoviesApp
//
//  Created by Lucas Galvao on 05/01/23.
//

import Foundation
import UIKit

class SeriesViewController: UIViewController{
    
    //MARK: - Labels
    lazy var popularLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        lb.lineBreakMode = .byWordWrapping
        lb.font = UIFont.boldSystemFont(ofSize: 25)
        lb.textColor = .white
        lb.textAlignment = .left
        lb.text = "Series Populares"
        return lb
    }()
    
    lazy var topRatedLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        lb.lineBreakMode = .byWordWrapping
        lb.font = UIFont.boldSystemFont(ofSize: 25)
        lb.textColor = .white
        lb.textAlignment = .left
        lb.text = "Favoritos"
        return lb
    }()
    
    lazy var upcomingLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        lb.lineBreakMode = .byWordWrapping
        lb.font = UIFont.boldSystemFont(ofSize: 25)
        lb.textColor = .white
        lb.textAlignment = .left
        lb.text = "Em Breve"
        return lb
    }()
    
    lazy var nowPlayingLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        lb.lineBreakMode = .byWordWrapping
        lb.font = UIFont.boldSystemFont(ofSize: 25)
        lb.textColor = .white
        lb.textAlignment = .left
        lb.text = "Em Cartaz"
        return lb
    }()
    
    lazy var latestLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        lb.lineBreakMode = .byWordWrapping
        lb.font = UIFont.boldSystemFont(ofSize: 25)
        lb.textColor = .white
        lb.textAlignment = .left
        lb.text = "Últimos Lançamentos"
        return lb
    }()
    
    //MARK: - CollectionView
    lazy var popularCollectionView: UICollectionView = {
        let layoutCollection = UICollectionViewFlowLayout()
        layoutCollection.scrollDirection = .horizontal
        layoutCollection.itemSize = CGSize(width: 120, height: 190)
        layoutCollection.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layoutCollection.minimumLineSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layoutCollection )
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self
        collection.register(SeriesCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collection.tag = 0
        return collection
    }()
    
    lazy var topRatedCollectionView: UICollectionView = {
        let layoutCollection = UICollectionViewFlowLayout()
        layoutCollection.scrollDirection = .horizontal
        layoutCollection.itemSize = CGSize(width: 120, height: 190)
        layoutCollection.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layoutCollection.minimumLineSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layoutCollection )
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self
        collection.register(SeriesCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collection.tag = 1
        return collection
    }()
    
    lazy var upcomingCollectionView: UICollectionView = {
        let layoutCollection = UICollectionViewFlowLayout()
        layoutCollection.scrollDirection = .horizontal
        layoutCollection.itemSize = CGSize(width: 120, height: 190)
        layoutCollection.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layoutCollection.minimumLineSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layoutCollection )
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self
        collection.register(SeriesCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collection.tag = 2
        return collection
    }()
    
    lazy var nowPlayingCollectionView: UICollectionView = {
        let layoutCollection = UICollectionViewFlowLayout()
        layoutCollection.scrollDirection = .horizontal
        layoutCollection.itemSize = CGSize(width: 120, height: 190)
        layoutCollection.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layoutCollection.minimumLineSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layoutCollection )
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self
        collection.register(SeriesCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collection.tag = 3
        return collection
    }()
    
    lazy var latestCollectionView: UICollectionView = {
        let layoutCollection = UICollectionViewFlowLayout()
        layoutCollection.scrollDirection = .horizontal
        layoutCollection.itemSize = CGSize(width: 120, height: 190)
        layoutCollection.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layoutCollection.minimumLineSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layoutCollection )
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self
        collection.register(SeriesCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collection.tag = 4
        return collection
    }()
    
    //MARK: - ScrollView
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: view.bounds)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.isScrollEnabled = true
        scroll.showsVerticalScrollIndicator = false
        scroll.addSubview(uiView)
        scroll.addSubview(popularLabel)
        scroll.addSubview(topRatedLabel)
        scroll.addSubview(upcomingLabel)
        scroll.addSubview(nowPlayingLabel)
        scroll.addSubview(latestLabel)
        scroll.addSubview(popularCollectionView)
        scroll.addSubview(topRatedCollectionView)
        scroll.addSubview(upcomingCollectionView)
        scroll.addSubview(nowPlayingCollectionView)
        scroll.addSubview(latestCollectionView)
        return scroll
    }()
    
    //MARK: - UIView
    private lazy var uiView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    
    //MARK: - viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.addSubview(scrollView)
        configConstraints()
        view.backgroundColor = .systemGray
    }
    
    //MARK: - Constraints
    private func configConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            uiView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            uiView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            uiView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            uiView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            popularLabel.topAnchor.constraint(equalTo: uiView.topAnchor, constant: 10),
            popularLabel.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 10),
            
            popularCollectionView.topAnchor.constraint(equalTo: popularLabel.bottomAnchor),
            popularCollectionView.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 10),
            popularCollectionView.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -10),
            popularCollectionView.heightAnchor.constraint(equalToConstant: 250),
            
            topRatedLabel.topAnchor.constraint(equalTo: popularCollectionView.bottomAnchor, constant: 10),
            topRatedLabel.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 10),
            
            topRatedCollectionView.topAnchor.constraint(equalTo: topRatedLabel.bottomAnchor),
            topRatedCollectionView.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 10),
            topRatedCollectionView.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -10),
            topRatedCollectionView.heightAnchor.constraint(equalToConstant: 250),
            
            upcomingLabel.topAnchor.constraint(equalTo: topRatedCollectionView.bottomAnchor, constant: 10),
            upcomingLabel.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 10),

            upcomingCollectionView.topAnchor.constraint(equalTo: upcomingLabel.bottomAnchor),
            upcomingCollectionView.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 10),
            upcomingCollectionView.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -10),
            upcomingCollectionView.heightAnchor.constraint(equalToConstant: 250),

            nowPlayingLabel.topAnchor.constraint(equalTo: upcomingCollectionView.bottomAnchor, constant: 10),
            nowPlayingLabel.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 10),

            nowPlayingCollectionView.topAnchor.constraint(equalTo: nowPlayingLabel.bottomAnchor),
            nowPlayingCollectionView.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 10),
            nowPlayingCollectionView.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -10),
            nowPlayingCollectionView.heightAnchor.constraint(equalToConstant: 250),

            latestLabel.topAnchor.constraint(equalTo: nowPlayingCollectionView.bottomAnchor, constant: 10),
            latestLabel.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 10),

            latestCollectionView.topAnchor.constraint(equalTo: latestLabel.bottomAnchor),
            latestCollectionView.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 10),
            latestCollectionView.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -10),
            latestCollectionView.heightAnchor.constraint(equalToConstant: 250),
            latestCollectionView.bottomAnchor.constraint(equalTo: uiView.bottomAnchor),
        ])
    }
}

//MARK: - Extension MovieDetailsViewController
extension SeriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? SeriesCollectionViewCell
        
        return cell ?? UICollectionViewCell()
    }
}
