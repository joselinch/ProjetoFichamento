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

//MARK: Retorna fichas
//func returnCardsList(id: String) -> [Card] {
//    //
//    return [Card]
//}
////MARK: Retorna ficha
//func returnCard(id: String) -> Card {
//    //
//    return Card
//}

//MARK: Adiciona ficha
//func addCard(category: Category, title: String, ) {
//
//}

//MARK: Remove ficha
func removeCard(id: String, card: Card) {
    context.delete(card)
}

////MARK: Salva ficha
//func saveCard(id: String, card: Card) {
//    //
//}
////MARK: Duplicar ficha
//func duplicateCard(id: String, card: Card) {
//    //
//}

//MARK: Editar Ficha

//MARK: Retorna categorias
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
}

////MARK: Salva categoria
//
////MARK: Insere anexo
//
////MARK: Remove anexo
//
////MARK: Pesquisar
