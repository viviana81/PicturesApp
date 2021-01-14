//
//  Coordinator.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 14/01/21.
//

import UIKit

protocol Coordinator {
    var coordinators: [Coordinator] { get set }
    func start()
}
