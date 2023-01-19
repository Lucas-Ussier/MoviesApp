//
//  MovieViewController.swift
//  MoviesApp
//
//  Created by Lucas Galvao on 17/01/23.
//

import Foundation
import UIKit

class MovieViewController: UIViewController{
    
    private let movieViewModel: MovieViewModel = MovieViewModel()
    
    private lazy var viewScrollView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private lazy var scrollView: UIScrollView = {
       let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    //MARK: - Popular Movies
    private lazy var popularTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Populares"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .horizontal
         layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 170,
                                 height: 290)
         layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return layout
    }()
    
    private lazy var popularMoviesColletcion: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .systemGray
        collection.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        collection.tag = 0
        return collection
    }()
    
    //MARK: - Top Rated Movies
    private lazy var topRatedTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Favoritos"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var topRatedMoviesColletcion: UICollectionView = {
       
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .systemGray
        collection.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        collection.tag = 1
        return collection
    }()
    
    //MARK: - Upcoming Movies
    private lazy var upcomingTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Em breve"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var upcomingMoviesColletcion: UICollectionView = {
       
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .systemGray
        collection.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        collection.tag = 2
        return collection
    }()
    
    
    //MARK: - Now Playing Movies
    private lazy var nowPlayingTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Em Cartaz"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var nowPlayingMoviesColletcion: UICollectionView = {
      
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .systemGray
        collection.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        collection.tag = 3
        return collection
    }()
    
    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCollectionConfig()
        self.view.backgroundColor = .systemGray3
        addSubviews()
        setConstraints()
        
    }
    
    private func setCollectionConfig(){
       let collectionViews = [popularMoviesColletcion, topRatedMoviesColletcion, upcomingMoviesColletcion, nowPlayingMoviesColletcion]
        for collectionView in collectionViews {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    private func addSubviews(){
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(viewScrollView)
        self.viewScrollView.addSubview(popularMoviesColletcion)
        self.viewScrollView.addSubview(popularTitleLabel)
        self.viewScrollView.addSubview(topRatedTitleLabel)
        self.viewScrollView.addSubview(topRatedMoviesColletcion)
        self.viewScrollView.addSubview(upcomingTitleLabel)
        self.viewScrollView.addSubview(upcomingMoviesColletcion)
        self.viewScrollView.addSubview(nowPlayingTitleLabel)
        self.viewScrollView.addSubview(nowPlayingMoviesColletcion)
    }
    
    //MARK: - Constraints
    private func setConstraints(){
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            
            
            self.viewScrollView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.viewScrollView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.viewScrollView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            self.viewScrollView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            
            self.popularTitleLabel.topAnchor.constraint(equalTo: self.viewScrollView.topAnchor, constant: 10),
            self.popularTitleLabel.leadingAnchor.constraint(equalTo: self.viewScrollView.leadingAnchor, constant: 10),
            
            self.popularMoviesColletcion.topAnchor.constraint(equalTo: self.popularTitleLabel.bottomAnchor, constant: 10),
            self.popularMoviesColletcion.leadingAnchor.constraint(equalTo: self.viewScrollView.leadingAnchor, constant: 10),
            self.popularMoviesColletcion.trailingAnchor.constraint(equalTo: self.viewScrollView.trailingAnchor, constant: -10),
            self.popularMoviesColletcion.heightAnchor.constraint(equalToConstant: 300),
            
            
            self.topRatedTitleLabel.topAnchor.constraint(equalTo: self.popularMoviesColletcion.bottomAnchor, constant: 10),
            self.topRatedTitleLabel.leadingAnchor.constraint(equalTo: self.popularTitleLabel.leadingAnchor),
            
            self.topRatedMoviesColletcion.topAnchor.constraint(equalTo: self.topRatedTitleLabel.bottomAnchor, constant: 10),
            self.topRatedMoviesColletcion.leadingAnchor.constraint(equalTo: self.popularMoviesColletcion.leadingAnchor),
            self.topRatedMoviesColletcion.trailingAnchor.constraint(equalTo: self.popularMoviesColletcion.trailingAnchor),
            self.topRatedMoviesColletcion.heightAnchor.constraint(equalTo: popularMoviesColletcion.heightAnchor),
            
            
            self.upcomingTitleLabel.topAnchor.constraint(equalTo: self.topRatedMoviesColletcion.bottomAnchor, constant: 10),
            self.upcomingTitleLabel.leadingAnchor.constraint(equalTo: self.popularTitleLabel.leadingAnchor),
            
            self.upcomingMoviesColletcion.topAnchor.constraint(equalTo: self.upcomingTitleLabel.bottomAnchor, constant: 10),
            self.upcomingMoviesColletcion.leadingAnchor.constraint(equalTo: self.popularMoviesColletcion.leadingAnchor),
            self.upcomingMoviesColletcion.trailingAnchor.constraint(equalTo: self.popularMoviesColletcion.trailingAnchor),
            self.upcomingMoviesColletcion.heightAnchor.constraint(equalTo: popularMoviesColletcion.heightAnchor),
            
            
            self.nowPlayingTitleLabel.topAnchor.constraint(equalTo: self.upcomingMoviesColletcion.bottomAnchor, constant: 10),
            self.nowPlayingTitleLabel.leadingAnchor.constraint(equalTo: self.popularTitleLabel.leadingAnchor),
            
            self.nowPlayingMoviesColletcion.topAnchor.constraint(equalTo: self.nowPlayingTitleLabel.bottomAnchor, constant: 10),
            self.nowPlayingMoviesColletcion.leadingAnchor.constraint(equalTo: self.popularMoviesColletcion.leadingAnchor),
            self.nowPlayingMoviesColletcion.trailingAnchor.constraint(equalTo: self.popularMoviesColletcion.trailingAnchor),
            self.nowPlayingMoviesColletcion.heightAnchor.constraint(equalTo: popularMoviesColletcion.heightAnchor),
            self.nowPlayingMoviesColletcion.bottomAnchor.constraint(equalTo: self.viewScrollView.bottomAnchor),
            
           
        ])
    }
}

//MARK: - Collection Extension
extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return self.movieViewModel.count(category: .Popular)
            
        case 1:
            return self.movieViewModel.count(category: .TopRated)
            
        case 2:
            return self.movieViewModel.count(category: .Upcoming)
            
        case 3:
            return self.movieViewModel.count(category: .NowPlaying)
            
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell
        
        switch collectionView.tag {
        case 0:
            cell?.setupCell(url: self.movieViewModel.getMovieImagePath(category: .Popular, indexPath: indexPath))
            
        case 1:
            cell?.setupCell(url: self.movieViewModel.getMovieImagePath(category: .TopRated, indexPath: indexPath))
            
        case 2:
            cell?.setupCell(url: self.movieViewModel.getMovieImagePath(category: .Upcoming, indexPath: indexPath))
            
        case 3:
            cell?.setupCell(url: self.movieViewModel.getMovieImagePath(category: .NowPlaying, indexPath: indexPath))
        default:
            break
            
        }
        return cell ?? UICollectionViewCell()
    }
}


extension MovieViewController: CollectionViewReloadDelegate{
    func collectionViewReloadData(category: MovieCategory) {
        switch category {
        case .Popular:
            self.popularMoviesColletcion.reloadData()
        case .TopRated:
            self.topRatedMoviesColletcion.reloadData()
        case .Upcoming:
            self.upcomingMoviesColletcion.reloadData()
        case .NowPlaying:
            self.nowPlayingMoviesColletcion.reloadData()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var detailsViewController: MovieDetailsViewController?
        
        switch collectionView.tag {
        case 0:
            detailsViewController = MovieDetailsViewController(movieId: self.movieViewModel.getMovieId(category: .Popular, indexPath: indexPath),category: .Popular)
            
        case 1:
            detailsViewController = MovieDetailsViewController(movieId: self.movieViewModel.getMovieId(category: .TopRated, indexPath: indexPath),category: .TopRated)
            
        case 2:
            detailsViewController = MovieDetailsViewController(movieId: self.movieViewModel.getMovieId(category: .Upcoming, indexPath: indexPath),category: .Upcoming)
            
        case 3:
            detailsViewController = MovieDetailsViewController(movieId: self.movieViewModel.getMovieId(category: .NowPlaying, indexPath: indexPath),category: .NowPlaying)
            
        default:
            break
            
        }
        guard let detailsViewController else {return}
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
