//
//  Search+CoreDataProperties.swift
//  ProjetoFichamento
//
//  Created by Julia Silveira de Souza on 03/08/21.
//
//

import Foundation
import CoreData


extension Search {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Search> {
        return NSFetchRequest<Search>(entityName: "Search")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var search: String?

}

extension Search : Identifiable {

}
