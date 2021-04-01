//
//  DataManager.swift
//  Vaporusa
//
//  Created by Viviana Capolvenere on 09/02/21.
//

import Foundation

protocol DataManager {
    
    func getFlanges() -> [Flange]
    func addFlanges(_ flanges: [JSONFlange])
    
}
