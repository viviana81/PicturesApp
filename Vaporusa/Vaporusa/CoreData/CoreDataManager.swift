//
//  CoreDataManager.swift
//  Vaporusa
//
//  Created by Viviana Capolvenere on 09/02/21.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager: DataManager {
    
    static let shared = CoreDataManager()
    
    private var context: NSManagedObjectContext
    
    private init() {
        
        let application = UIApplication.shared.delegate as! AppDelegate
        self.context = application.persistentContainer.viewContext
    }
    
    func getFlanges() -> [Flange] {
        let fetchRequest: NSFetchRequest<Flange> = Flange.fetchRequest()
        
        let array = try? self.context.fetch(fetchRequest)
        return array ?? []
    }
    
    func addFlanges(_ flanges: [JSONFlange]) {
        
        for flange in flanges {
            
            let entity = NSEntityDescription.entity(forEntityName: "Flange", in: self.context)
            
            let newFlange = Flange(entity: entity!, insertInto: self.context)
            
            newFlange.diameter = flange.diameter
            newFlange.holes = Int16(flange.holes)
            newFlange.wheelbase = flange.wheelbase
            
            do {
                try self.context.save()
            } catch let errore {
                print("[CDC] Problema salvataggio")
                print("  Stampo l'errore: \n \(errore) \n")
            }
            
            print("[CDC] Salvato in memoria correttamente")
        }
    }
}
