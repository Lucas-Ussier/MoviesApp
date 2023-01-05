//
//  HomeViewController.swift
//  MoviesApp
//
//  Created by Lucas Galvao on 14/10/22.
//

import UIKit

class MovieViewController: UIViewController {
    
    let network = Network.shared
    
    private let viewModel: MovieViewModel = MovieViewModel()
    
    let segmentedControl: UISegmentedControl = {
        let buttons = UISegmentedControl(items: ["UpComing","Popular"])
        buttons.translatesAutoresizingMaskIntoConstraints = false
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .normal)
        let titleTextAttributes2 = [NSAttributedString.Key.foregroundColor: UIColor.black]
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes2, for: .selected)
        buttons.layer.borderWidth = 2
        buttons.layer.borderColor = UIColor.white.cgColor
        buttons.selectedSegmentTintColor = .white
        buttons.selectedSegmentIndex = 0
        return buttons
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "UpComing Movies"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var collectionView1: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 130, height: 200)
        layout.minimumLineSpacing = 50
        layout.minimumInteritemSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(MovieCollectionCell.self, forCellWithReuseIdentifier: "Cell")
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray
        self.network.delegate = self
        network.getUpcomingMovie()
        
        view.addSubview(segmentedControl)
        view.addSubview(titleLabel)
        view.addSubview(collectionView1)
        addConstraints()
        
        segmentedControl.addTarget(nil, action: #selector(segmentedValueChanged), for: .valueChanged)
    }
    
    @objc func segmentedValueChanged() {
        
        switch segmentedControl.selectedSegmentIndex {
        case 1:
            titleLabel.text = "Popular Movies"
            network.getPopularMovie()
        default:
            titleLabel.text = "UpComing Movies"
            network.getUpcomingMovie()
        }
    }
    
    func addConstraints() {
        segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        segmentedControl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        collectionView1.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        collectionView1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView1.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension MovieViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? MovieCollectionCell
        
        self.viewModel.getImage(at: indexPath, imageView: cell?.movieImage, titleLabel: self.titleLabel)
        DispatchQueue.main.async {
            cell?.nameMovieLabel.text = self.viewModel.getTitle(at: indexPath, titleLabel: self.titleLabel)
            cell?.dateLabel.text = self.viewModel.getDate(at: indexPath, titleLabel: self.titleLabel)
        }
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.titleLabel.text == "Popular Movies"{
            Movies.currentMovieId = network.dataBasePopular[indexPath.row].id
            if let movieId = Movies.currentMovieId{
                DispatchQueue.main.async {
                    Network.shared.getMovieDetails(id: movieId)
                    Network.shared.getMovieCast(id: movieId)
                    let vc = MovieDetailsViewController()
                    vc.currentTitle = self.titleLabel.text
                    vc.movieId = movieId
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }else{
            Movies.currentMovieId = network.dataBase[indexPath.row].id
            if let movieId = Movies.currentMovieId{
                DispatchQueue.main.async {
                    Network.shared.getMovieDetails(id: movieId)
                    Network.shared.getMovieCast(id: movieId)
                }
                let vc = MovieDetailsViewController()
                vc.currentTitle = self.titleLabel.text
                vc.movieId = movieId
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

extension MovieViewController: CollectionViewReloadDelegate {
    
    func collectionViewReloadData() {
        self.collectionView1.reloadData()
    }
}


