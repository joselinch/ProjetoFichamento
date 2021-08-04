//
//  Category+CoreDataProperties.swift
//  ProjetoFichamento
//
//  Created by José Antônio Linch Burmann on 02/08/21.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var emoji: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var card: NSSet?

}

// MARK: Generated accessors for card
extension Category {

    @objc(addCardObject:)
    @NSManaged public func addToCard(_ value: Card)

    @objc(removeCardObject:)
    @NSManaged public func removeFromCard(_ value: Card)

    @objc(addCard:)
    @NSManaged public func addToCard(_ values: NSSet)

    @objc(removeCard:)
    @NSManaged public func removeFromCard(_ values: NSSet)

}

extension Category : Identifiable {

}
