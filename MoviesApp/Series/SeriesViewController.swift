//
//  SeriesViewController.swift
//  MoviesApp
//
//  Created by Lucas Galvao on 05/01/23.
//

import Foundation
import UIKit

class SeriesViewController: UIViewController{
    
    private let network = Network.shared
    private var delegate: SeriesCollectionViewReloadDelegate?
    private let seriesViewModel: SeriesViewModel = SeriesViewModel()
    
    //MARK: - Labels
    lazy var popularLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        lb.lineBreakMode = .byWordWrapping
        lb.font = UIFont.boldSystemFont(ofSize: 25)
        lb.textColor = .white
        lb.textAlignment = .left
        lb.text = "Populares"
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
        lb.text = "Favoritas"
        return lb
    }()
    
    lazy var tvAiringTodayLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        lb.lineBreakMode = .byWordWrapping
        lb.font = UIFont.boldSystemFont(ofSize: 25)
        lb.textColor = .white
        lb.textAlignment = .left
        lb.text = "Hoje Na TV"
        return lb
    }()
    
    lazy var tvOnTheAirLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        lb.lineBreakMode = .byWordWrapping
        lb.font = UIFont.boldSystemFont(ofSize: 25)
        lb.textColor = .white
        lb.textAlignment = .left
        lb.text = "No Ar"
        return lb
    }()
    
    //MARK: - CollectionView
    lazy var popularCollectionView: UICollectionView = {
        let layoutCollection = UICollectionViewFlowLayout()
        layoutCollection.scrollDirection = .horizontal
        layoutCollection.itemSize = CGSize(width: 170, height: 290)
        layoutCollection.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layoutCollection.minimumLineSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layoutCollection )
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .systemGray
        collection.dataSource = self
        collection.delegate = self
        collection.register(SeriesCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collection.tag = 0
        return collection
    }()
    
    lazy var topRatedCollectionView: UICollectionView = {
        let layoutCollection = UICollectionViewFlowLayout()
        layoutCollection.scrollDirection = .horizontal
        layoutCollection.itemSize = CGSize(width: 170, height: 290)
        layoutCollection.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layoutCollection.minimumLineSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layoutCollection )
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .systemGray
        collection.dataSource = self
        collection.delegate = self
        collection.register(SeriesCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collection.tag = 1
        return collection
    }()
    
    lazy var tvAiringTodayCollectionView: UICollectionView = {
        let layoutCollection = UICollectionViewFlowLayout()
        layoutCollection.scrollDirection = .horizontal
        layoutCollection.itemSize = CGSize(width: 170, height: 290)
        layoutCollection.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layoutCollection.minimumLineSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layoutCollection )
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .systemGray
        collection.dataSource = self
        collection.delegate = self
        collection.register(SeriesCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collection.tag = 2
        return collection
    }()
    
    lazy var tvOnTheAirCollectionView: UICollectionView = {
        let layoutCollection = UICollectionViewFlowLayout()
        layoutCollection.scrollDirection = .horizontal
        layoutCollection.itemSize = CGSize(width: 170, height: 290)
        layoutCollection.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layoutCollection.minimumLineSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layoutCollection )
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .systemGray
        collection.dataSource = self
        collection.delegate = self
        collection.register(SeriesCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collection.tag = 3
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
        scroll.addSubview(tvAiringTodayLabel)
        scroll.addSubview(tvOnTheAirLabel)
        scroll.addSubview(popularCollectionView)
        scroll.addSubview(topRatedCollectionView)
        scroll.addSubview(tvAiringTodayCollectionView)
        scroll.addSubview(tvOnTheAirCollectionView)
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
        self.delegate = self
    }
    
    //MARK: - viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.addSubview(scrollView)
        configConstraints()
        view.backgroundColor = .systemGray3
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
            popularCollectionView.heightAnchor.constraint(equalToConstant: 300),
            
            topRatedLabel.topAnchor.constraint(equalTo: popularCollectionView.bottomAnchor, constant: 10),
            topRatedLabel.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 10),
            
            topRatedCollectionView.topAnchor.constraint(equalTo: topRatedLabel.bottomAnchor),
            topRatedCollectionView.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 10),
            topRatedCollectionView.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -10),
            topRatedCollectionView.heightAnchor.constraint(equalToConstant: 300),
            
            tvAiringTodayLabel.topAnchor.constraint(equalTo: topRatedCollectionView.bottomAnchor, constant: 10),
            tvAiringTodayLabel.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 10),

            tvAiringTodayCollectionView.topAnchor.constraint(equalTo: tvAiringTodayLabel.bottomAnchor),
            tvAiringTodayCollectionView.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 10),
            tvAiringTodayCollectionView.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -10),
            tvAiringTodayCollectionView.heightAnchor.constraint(equalToConstant: 300),

            tvOnTheAirLabel.topAnchor.constraint(equalTo: tvAiringTodayCollectionView.bottomAnchor, constant: 10),
            tvOnTheAirLabel.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 10),
            
            tvOnTheAirCollectionView.topAnchor.constraint(equalTo: tvOnTheAirLabel.bottomAnchor),
            tvOnTheAirCollectionView.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 10),
            tvOnTheAirCollectionView.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -10),
            tvOnTheAirCollectionView.heightAnchor.constraint(equalToConstant: 300),
            tvOnTheAirCollectionView.bottomAnchor.constraint(equalTo: uiView.bottomAnchor),
        ])
    }
}

//MARK: - Extension MovieDetailsViewController
extension SeriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return self.seriesViewModel.count(category: .Popular)
            
        case 1:
            return self.seriesViewModel.count(category: .TopRated)
            
        case 2:
            return self.seriesViewModel.count(category: .TVAiringToday)
            
        case 3:
            return self.seriesViewModel.count(category: .TVOnTheAir)
            
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? SeriesCollectionViewCell
        
        switch collectionView.tag {
        case 0:
            cell?.setupCell(url: self.seriesViewModel.getSerieImagePath(category: .Popular, indexPath: indexPath))
            
        case 1:
            cell?.setupCell(url: self.seriesViewModel.getSerieImagePath(category: .TopRated, indexPath: indexPath))
            
        case 2:
            cell?.setupCell(url: self.seriesViewModel.getSerieImagePath(category: .TVAiringToday, indexPath: indexPath))
            
        case 3:
            cell?.setupCell(url: self.seriesViewModel.getSerieImagePath(category: .TVOnTheAir, indexPath: indexPath))
        default:
            break
        }
        return cell ?? UICollectionViewCell()
    }
}

//MARK: - Extension SeriesCollectionViewReloadDelegate
extension SeriesViewController: SeriesCollectionViewReloadDelegate {
    func collectionViewReloadData(category: SeriesCategory) {
        switch category {
        case .Popular:
            self.popularCollectionView.reloadData()
        case .TopRated:
            self.topRatedCollectionView.reloadData()
        case .TVAiringToday:
            self.tvAiringTodayCollectionView.reloadData()
        case .TVOnTheAir:
            self.tvOnTheAirCollectionView.reloadData()
        }
    } 
}
