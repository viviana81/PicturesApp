//
//  DetailCoordinator.swift
//  MusicStore
//
//  Created by Viviana Capolvenere on 12/02/21.
//

import Foundation
import UIKit

class DetailCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let detaiVC: DetailViewController
    let presenter: UIViewController
    var onDismiss: (() -> Void)?
    let navigator: UINavigationController
    
    init(album: Album, presenter: UIViewController) {
        detaiVC = DetailViewController(detailViewModel: DetailViewModel(album: album))
        navigator = UINavigationController(rootViewController: detaiVC)
        self.presenter = presenter
    }

    func start() {
        navigator.modalPresentationStyle = .fullScreen
        presenter.present(navigator, animated: true, completion: nil)
        detaiVC.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismiss))
    }
    
    @objc
    func dismiss() {
        presenter.dismiss(animated: true, completion: nil)
        onDismiss?()
    }
}
