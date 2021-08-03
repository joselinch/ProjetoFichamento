//
//  Files+CoreDataProperties.swift
//  ProjetoFichamento
//
//  Created by José Antônio Linch Burmann on 02/08/21.
//
//

import Foundation
import CoreData


extension Files {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Files> {
        return NSFetchRequest<Files>(entityName: "Files")
    }

    @NSManaged public var archive: URL?
    @NSManaged public var fileName: String?
    @NSManaged public var id: UUID?
    @NSManaged public var type: String?
    @NSManaged public var card: Card?

}

extension Files : Identifiable {

}
