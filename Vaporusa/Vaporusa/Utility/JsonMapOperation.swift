//
//  JsonMapOperation.swift
//  Vaporusa
//
//  Created by Viviana Capolvenere on 09/02/21.
//

import Foundation

final class JsonMapOperation<Model: Decodable> {
    
    func decode(from path: String) -> Model? {
        
        let bundle = Bundle(for: type(of: self))
        
        guard let jsonFile = bundle.path(forResource: path, ofType: "json") else {
            return nil
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: jsonFile), options: []) else {
            return nil
        }
        
        let decoder = JSONDecoder()
        let model = try! decoder.decode(Model.self, from: data)
        return model
    }
}
