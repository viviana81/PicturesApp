//
//  StopsCoordinator.swift
//  Septa
//
//  Created by Viviana Capolvenere on 18/02/21.
//

import Foundation
import UIKit

class StopsCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let stopsVC: StopsViewController
    let presenter: UIViewController
    let navigation: UINavigationController
    
    init( presenter: UIViewController) {
        self.presenter = presenter
        stopsVC = StopsViewController(stopsVM: StopsViewModel())
        navigation = UINavigationController(rootViewController: stopsVC)
    }
    
    func start() {
        navigation.modalPresentationStyle = .fullScreen
        presenter.present(navigation, animated: true, completion: nil)
    }
}
