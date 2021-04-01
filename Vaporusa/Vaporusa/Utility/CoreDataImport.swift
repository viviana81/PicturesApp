//
//  FlangesStore.swift
//  Vaporusa
//
//  Created by Viviana Capolvenere on 09/02/21.
//

import Foundation

class CoreDataImport {
    
    private let json: String
    let dataManager: DataManager
    
    init(withJson json: String, dataManager: DataManager) {
        self.json = json
        self.dataManager = dataManager
    }
    
    public func importData() {
     
        let jsonMap = JsonMapOperation<[JSONFlange]>()
        
        guard let flanges = jsonMap.decode(from: json) else {
            fatalError("Invalid json")
        }
        
        dataManager.addFlanges(flanges)
    }
}
