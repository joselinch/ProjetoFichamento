//
//  Card+CoreDataProperties.swift
//  ProjetoFichamento
//
//  Created by José Antônio Linch Burmann on 02/08/21.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var anotations: String?
    @NSManaged public var author: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var reference: String?
    @NSManaged public var status: String?
    @NSManaged public var title: String?
    @NSManaged public var categories: Categories?
    @NSManaged public var files: NSSet?

}

// MARK: Generated accessors for files
extension Card {

    @objc(addFilesObject:)
    @NSManaged public func addToFiles(_ value: Files)

    @objc(removeFilesObject:)
    @NSManaged public func removeFromFiles(_ value: Files)

    @objc(addFiles:)
    @NSManaged public func addToFiles(_ values: NSSet)

    @objc(removeFiles:)
    @NSManaged public func removeFromFiles(_ values: NSSet)

}

extension Card : Identifiable {

}
