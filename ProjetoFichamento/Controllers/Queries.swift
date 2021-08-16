//
//  Queries.swift
//  ProjetoFichamento
//
//  Created by José Antônio Linch Burmann on 02/08/21.
//

import Foundation
import UIKit

//MARK: Definição do context
let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

var items:[Category]?

//MARK: CARD: São as fichas do fichamento bibliográfico

//MARK: Adiciona ficha

func addCard(category: Category, cardAnotation: String, cardAuthor: String, cardDate: Date, cardIsFavorite: Bool, cardReference: String, cardStatus: String, cardTitle: String) -> Card {
    let card = Card(context: context)
    card.anotations = cardAnotation
    card.author = cardAuthor
    card.title = cardTitle
    card.date = cardDate
    card.isFavorite = cardIsFavorite
    card.reference = cardReference
    card.status = cardStatus
    category.addToCard(card)
    
    do {
        try context.save()
        return card
    } catch {
        print("Erro!")
    }
    return card
}

//MARK: Remove ficha

func removeCard(category: Category, card: Card) {
    category.removeFromCard(card)
    context.delete(card)
    
    do {
        try context.save()
    } catch {
        //
    }
}

//MARK: Duplica ficha
func duplicateCard(card: Card, category: Category) {
    let newCard = Card(context: context)
    newCard.anotations = card.anotations
    newCard.author = card.author
    newCard.date = card.date
    newCard.title = card.title
    newCard.status = card.status
    newCard.files = card.files
    newCard.isFavorite = card.isFavorite
    newCard.reference = card.reference
    
    category.addToCard(newCard)
    
    do {
        try context.save()
    } catch {
        print("Erro!")
    }
}

//MARK: Edita Ficha

func editCard(oldCategory: Category, newCategory: Category, card: Card, cardAnotation: String, cardAuthor: String, cardDate: Date, cardIsFavorite: Bool, cardReference: String, cardStatus: String, cardTitle: String){
    card.anotations = cardAnotation
    card.author = cardAuthor
    card.date = cardDate
    card.title = cardTitle
    card.status = cardStatus
    card.isFavorite = cardIsFavorite
    card.reference = cardReference

    
    if oldCategory == newCategory {

    }
    else {
        newCategory.addToCard(card)
        oldCategory.removeFromCard(card)
    }
    
    do {
        try context.save()
    }
    catch {
        print("Erro!")
    }
}

//---------------------------------------------

//MARK: CATEGORY: São as pastas aonde ficam os fichamentos

//MARK: Retorna categoria
func returnCategory() -> [Category]? {
    do {
        items = try context.fetch(Category.fetchRequest())
        return items
    } catch {
        //
    }
    return items
}

//MARK: Adiciona categoria
func addCategory(name: String) {
    let category = Category(context: context)
    category.name = name
    
    do {
        try context.save()
    } catch {
         print("Erro")
    }
}

//MARK: Remove categoria
func deleteCategory(category:Category){
    context.delete(category)
    
    do {
        try context.save()
    } catch {
        print("Erro!")
    }
}

//MARK: Salva categoria
func editCategory(category: Category, categoryName: String){
    category.name = categoryName
    
    do {
        try context.save()
    } catch {
        print("Erro!")
    }
}

//---------------------------------------

//MARK: FILES: São os anexos dos fichamentos

//MARK: Insere anexo
func addFile(card: Card, fileURL: URL, fileName: String) {
    let file = Files(context: context)
    file.fileName = fileName
    file.archive = fileURL
    
    card.addToFiles(file)
    
    do {
        try context.save()
    } catch {
        print("Erro!")
    }
}

//MARK: Remove anexo
func removeFile(file: Files) {
    context.delete(file)
}
