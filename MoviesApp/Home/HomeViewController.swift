//
//  HomeViewController.swift
//  MoviesApp
//
//  Created by Lucas Galvao on 05/01/23.
//

import Foundation
import UIKit

class HomeViewController: UIViewController{
    
    let movieCategoriesArray = [
        MovieCategory.Upcoming,
        MovieCategory.NowPlaying,
        MovieCategory.TopRated,
        MovieCategory.Popular,
    ]
    
    let seriesCategoriesArray = [
        SeriesCategory.Popular,
        SeriesCategory.TopRated,
        SeriesCategory.TVAiringToday,
        SeriesCategory.TVOnTheAir,
    ]
    
    private lazy var appNameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No Name App"
        label.textColor = .systemPink
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var homeLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person")
        return imageView
    }()
    
    private lazy var movieButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Movies", for: .normal)
        button.backgroundColor = .systemPink
        button.setTitleColor(.systemBackground, for: .normal)
        return button
    }()
    private lazy var seriesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Series", for: .normal)
        button.backgroundColor = .systemPink
        button.setTitleColor(.systemBackground, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        setupConstraints()
        addTargets()
        feedDataBases()
    }
    
    func feedDataBases(){
        for category in movieCategoriesArray {
            Network.shared.getMovie(category: category)
        }
        for category in seriesCategoriesArray {
            Network.shared.getSeries(category: category)
        }
    }
    
    func addSubviews(){
        self.view.addSubview(appNameLabel)
        self.view.addSubview(homeLogoImageView)
        self.view.addSubview(movieButton)
        self.view.addSubview(seriesButton)
    }
    
    func addTargets(){
        
        self.movieButton.addTarget(self, action: #selector(goToMovieView), for: .touchUpInside)
        self.seriesButton.addTarget(self, action: #selector(goToSeriesView), for: .touchUpInside)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            
            self.appNameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.appNameLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            self.appNameLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 12),
        
            self.homeLogoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.homeLogoImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.homeLogoImageView.heightAnchor.constraint(equalToConstant: 200),
            self.homeLogoImageView.widthAnchor.constraint(equalTo: homeLogoImageView.heightAnchor),
            
            self.seriesButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            self.seriesButton.leadingAnchor.constraint(equalTo:self.homeLogoImageView.leadingAnchor),
            self.seriesButton.trailingAnchor.constraint(equalTo:self.homeLogoImageView.trailingAnchor),
            
            self.movieButton.bottomAnchor.constraint(equalTo:self.seriesButton.topAnchor, constant: -30),
            self.movieButton.trailingAnchor.constraint(equalTo:self.seriesButton.trailingAnchor),
            self.movieButton.leadingAnchor.constraint(equalTo:self.seriesButton.leadingAnchor),
        ])
    }
    
    @objc func goToMovieView(){
        let movieViewController = MovieViewController()
        self.navigationController?.pushViewController(movieViewController, animated: true)
    }
    
    @objc func goToSeriesView(){
        let serieViewController = SeriesViewController()
        self.navigationController?.pushViewController(serieViewController, animated: true)
    }
}
