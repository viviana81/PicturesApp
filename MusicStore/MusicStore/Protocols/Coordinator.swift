//
//  Coordinator.swift
//  MusicStore
//
//  Created by Viviana Capolvenere on 12/02/21.
//

import Foundation

protocol Coordinator {
    var coordinators: [Coordinator] { get set }
    func start()
}
