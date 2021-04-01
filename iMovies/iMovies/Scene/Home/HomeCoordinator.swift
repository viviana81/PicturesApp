//
//  HomeCoordinator.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 22/02/21.
//

import UIKit

class HomeCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let window: UIWindow
    let homeVC: HomeViewController
    let navigation: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        homeVC = HomeViewController(homeVM: HomeViewModel())
        navigation = UINavigationController(rootViewController: homeVC)
        navigation.tabBarItem = UITabBarItem(title: "Movie Collection", image: UIImage(systemName: "film"), tag: 0)
    }
    
    func start() {
        homeVC.delegate = self
    }
}

extension HomeCoordinator: HomeViewControllerDelegate, DetailViewControllerDelegate {
    func openKeywordDetail(keyword: Keyword) {
        let keywordDetail = KeywordsTableViewController(keywordsVM: KeywordsViewModel(keyword: keyword))
        navigation.pushViewController(keywordDetail, animated: true)
    }
    
    func openGenreDetail(genre: Genre) {
        let genreDetail = GenreDetailTableViewController(genreDetailVM: GenreDetailViewModel(genre: genre))
        navigation.pushViewController(genreDetail, animated: true)
    }
    
    func openDetail(withId id: Int) {
        let detail = DetailViewController(detailVM: DetailViewModel(filmId: id))
        detail.delegate = self
        navigation.pushViewController(detail, animated: true)
    }
    
    func openGenre(_ genre: Genre) {
        let detail = GenreDetailTableViewController(genreDetailVM: GenreDetailViewModel(genre: genre))
        navigation.pushViewController(detail, animated: true)
    }
}
