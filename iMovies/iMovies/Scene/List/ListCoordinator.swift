//
//  ListCoordinator.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 23/02/21.
//

import Foundation
import UIKit

class ListCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let window: UIWindow
    let listContainer: ListContainerViewController
    let navigation: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        listContainer = ListContainerViewController(viewModel: HomeViewModel())
        navigation = UINavigationController(rootViewController: listContainer)
        navigation.tabBarItem = UITabBarItem(title: "Movie List", image: UIImage(systemName: "film.fill"), tag: 1)
    }
    
    func start() {
        listContainer.delegate = self
    }
}

extension ListCoordinator: ListContainerViewControllerDelegate {
    
    func openDetail(withViewModel viewModel: FilmViewModel) {
        let detail = DetailViewController(detailVM: .init(filmId: viewModel.film.id))
        navigation.pushViewController(detail, animated: true)
    }
}
