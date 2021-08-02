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


//MARK: Retorna fichas
func returnCards(id: String) -> [Card] {
    //
    return [Card]
}
//MARK: Retorna ficha
func returnCard(id: String) -> Card {
    //
    return Card
}
//MARK: Insere ficha
func insertCard(card: Card) {
    //
}
//MARK: Remove ficha
func removeCard(id: String, card: Card) {
    //
}
//MARK: Salva ficha
func saveCard(id: String, card: Card) {
    //
}
//MARK: Duplicar ficha
func duplicateCard(id: String, card: Card) {
    //
}
//MARK: Retorna categorias
func returnCategories() -> [Categories] {
    //
}
//MARK: Insere categoria
func insertCategory(category: Categories) {
    //
}
//MARK: Remove categoria

//MARK: Salva categoria

//MARK: Insere anexo

//MARK: Remove anexo

//MARK: Pesquisar
