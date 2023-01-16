//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by Lucas Galvao on 14/10/22.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    private let movieDetailsViewModel: MovieDetailsViewModel = MovieDetailsViewModel()
    var movieId: Int?
    var currentTitle: String?
    
    //MARK: - Image
    lazy var movieImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    //MARK: - Labels
    lazy var titleMovieLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        lb.lineBreakMode = .byWordWrapping
        lb.font = UIFont.boldSystemFont(ofSize: 25)
        lb.textColor = .white
        lb.textAlignment = .left
        return lb
    }()
    
    lazy var yearMovieLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 1
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.textColor = .white.withAlphaComponent(0.8)
        lb.textAlignment = .left
        return lb
    }()
    
    lazy var durationMovieLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 1
        lb.font = UIFont.systemFont(ofSize: 15)
        lb.textColor = .white.withAlphaComponent(0.8)
        lb.textAlignment = .left
        return lb
    }()
    
    lazy var separatorLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 1
        lb.text = "|"
        lb.font = UIFont.systemFont(ofSize: 15)
        lb.textColor = .white.withAlphaComponent(0.8)
        lb.textAlignment = .left
        return lb
    }()
    
    lazy var genreLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 1
        lb.font = UIFont.systemFont(ofSize: 15)
        lb.textColor = .white.withAlphaComponent(0.8)
        lb.textAlignment = .left
        return lb
    }()
    
    lazy var overviewMovieLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        lb.font = UIFont.systemFont(ofSize: 15)
        lb.textColor = .white
        lb.textAlignment = .left
        return lb
    }()
    
    //MARK: - CollectionView
    lazy var imageCollection: UICollectionView = {
        let layoutCollection = UICollectionViewFlowLayout()
        layoutCollection.scrollDirection = .horizontal
        layoutCollection.itemSize = CGSize(width: 120, height: 190)
        layoutCollection.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layoutCollection.minimumLineSpacing = 15
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layoutCollection )
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.register(MovieDetailsCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return collection
    }()
    
    //MARK: - ScrollView
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: view.bounds)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.isScrollEnabled = true
        scroll.showsVerticalScrollIndicator = false
        scroll.addSubview(uiView)
        scroll.addSubview(movieImage)
        scroll.addSubview(titleMovieLabel)
        scroll.addSubview(yearMovieLabel)
        scroll.addSubview(durationMovieLabel)
        scroll.addSubview(separatorLabel)
        scroll.addSubview(genreLabel)
        scroll.addSubview(imageCollection)
        scroll.addSubview(separatorLineView)
        scroll.addSubview(backgroundOverviewView)
        scroll.addSubview(overviewMovieLabel)
        return scroll
    }()
    
    //MARK: - UIView
    private lazy var uiView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var separatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backgroundOverviewView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray
        return view
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        imageCollection.delegate = self
        imageCollection.dataSource = self
        Network.shared.detailsDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        view.addSubview(scrollView)
        configConstraints()
        
        uiElementsSetup()
        view.backgroundColor = .systemGray
    }
    
    private func uiElementsSetup() {
        
        guard let movieId else { return }
        self.movieDetailsViewModel.getImage(at: movieId, imageView: self.movieImage, title: self.currentTitle)
        DispatchQueue.main.async {
            let movieInfo = self.movieDetailsViewModel.getMovieDetails()
            self.yearMovieLabel.text = movieInfo.release_date
            self.titleMovieLabel.text = movieInfo.title
            self.overviewMovieLabel.text = movieInfo.overview
            self.genreLabel.text = movieInfo.genres[0].name
            self.durationMovieLabel.text = String(movieInfo.runtime)+"m"
        }
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
            
            movieImage.topAnchor.constraint(equalTo: uiView.topAnchor),
            movieImage.leadingAnchor.constraint(equalTo: uiView.leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: uiView.trailingAnchor),
            movieImage.heightAnchor.constraint(equalToConstant: 200),
            
            titleMovieLabel.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 10),
            titleMovieLabel.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 10),
            
            yearMovieLabel.centerYAnchor.constraint(equalTo: titleMovieLabel.centerYAnchor),
            yearMovieLabel.leadingAnchor.constraint(equalTo: titleMovieLabel.trailingAnchor, constant: 20),
            yearMovieLabel.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -15),
            yearMovieLabel.widthAnchor.constraint(equalToConstant: 50),
            
            durationMovieLabel.topAnchor.constraint(equalTo: titleMovieLabel.bottomAnchor, constant: 10),
            durationMovieLabel.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 10),
            
            separatorLabel.centerYAnchor.constraint(equalTo: durationMovieLabel.centerYAnchor),
            separatorLabel.leadingAnchor.constraint(equalTo: durationMovieLabel.trailingAnchor, constant: 10),
            
            genreLabel.centerYAnchor.constraint(equalTo: durationMovieLabel.centerYAnchor),
            genreLabel.leadingAnchor.constraint(equalTo: separatorLabel.trailingAnchor, constant: 10),
            
            imageCollection.topAnchor.constraint(equalTo: durationMovieLabel.bottomAnchor, constant: 10),
            imageCollection.leadingAnchor.constraint(equalTo: uiView.leadingAnchor),
            imageCollection.trailingAnchor.constraint(equalTo: uiView.trailingAnchor),
            imageCollection.heightAnchor.constraint(equalToConstant: 210),
            
            separatorLineView.topAnchor.constraint(equalTo: backgroundOverviewView.topAnchor),
            separatorLineView.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 10),
            separatorLineView.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -10),
            separatorLineView.heightAnchor.constraint(equalToConstant: 0.3),
            
            backgroundOverviewView.topAnchor.constraint(equalTo: imageCollection.bottomAnchor),
            backgroundOverviewView.leadingAnchor.constraint(equalTo: uiView.leadingAnchor),
            backgroundOverviewView.trailingAnchor.constraint(equalTo: uiView.trailingAnchor),
            backgroundOverviewView.bottomAnchor.constraint(equalTo: uiView.bottomAnchor),
            
            overviewMovieLabel.topAnchor.constraint(equalTo: imageCollection.bottomAnchor, constant: 10),
            overviewMovieLabel.leadingAnchor.constraint(equalTo: backgroundOverviewView.leadingAnchor, constant: 10),
            overviewMovieLabel.trailingAnchor.constraint(equalTo: backgroundOverviewView.trailingAnchor, constant: -10),
            overviewMovieLabel.bottomAnchor.constraint(equalTo: backgroundOverviewView.bottomAnchor, constant: -10),
        ])
    }
}

//MARK: - Extension MovieDetailsViewController
extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.movieDetailsViewModel.castCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? MovieDetailsCollectionViewCell
        let cast: Cast = self.movieDetailsViewModel.getCast(at: indexPath.row)
        guard let castName = cast.name else {return UICollectionViewCell()}
        guard let castCharacter = cast.character else {return UICollectionViewCell()}
        DispatchQueue.main.async {
            self.movieDetailsViewModel.getCastImages(at: indexPath.row, imageView: cell?.movieImage)
            cell?.nameImageLabel.text = "\(castName)\n\(castCharacter)"
        }
        return cell ?? UICollectionViewCell()
    }
}

extension MovieDetailsViewController: DetailsCollectionViewReloadDelegate {
    
    func collectionViewReloadData() {
        self.imageCollection.reloadData()
    }
}
