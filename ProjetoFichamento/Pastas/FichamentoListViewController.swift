//
//  FichamentoListViewController.swift
//  ProjetoFichamento
//
//  Created by Eduarda Soares Serpa Camboim on 03/08/21.
//

import UIKit

//cell ID: title-fichamento

class FichamentoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBAction func addCardButton(_ sender: Any) {
        let alert = UIAlertController(title: "New Card", message: "Enter a title for this card", preferredStyle: .alert)
        
        alert.addTextField(){ (textField) in
            textField.placeholder = "Enter a title"
        }
        
        let alertCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(alertCancel)
        
        let alertSave = UIAlertAction(title: "Save", style: .default) { (action) in
            
            let textField = alert.textFields![0]
            
            let name = textField.text
            let data = Date()
            let card = addCard(category: self.category!, cardAnotation: "", cardAuthor: "", cardDate: data, cardIsFavorite: false, cardReference: "", cardStatus: "", cardTitle: name ?? "Faiooo")
            self.cards?.append(card)
            self.fetchData()
        }
        
        alert.addAction(alertSave)
        self.present(alert, animated: true, completion: nil)
    
    }
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var navbarTitle: UINavigationItem!
    var category: Category?
    var cards: [Card]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.dataSource = self
        tableView.delegate = self
        navbarTitle.title = category?.name
        
    }
    
    func fetchData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    } //retorna o número de pastas cadastradas
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (category?.card?.allObjects.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "title-fichamento", for: indexPath) as! FichamentosTableViewCell
         
        let card = cards?[indexPath.row]
        
        cell.titleLabel.text = card?.title

        return cell
    }
    
    func tableView(_ tableView: UITableView,  trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        
        //Delete
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){(action,view,completionHandler) in
            let cardSelected = self.cards![indexPath.row]
            
            let alert = UIAlertController(title: "Delete \(cardSelected.title ?? "") ?", message: "This will delete all the records in this folder", preferredStyle: .alert)
            
            let alertCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(alertCancel)
            
            let alertSave = UIAlertAction(title: "Delete", style: .default) { (action) in

                removeCard(card: cardSelected)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
            alert.addAction(alertSave)
            self.present(alert, animated: true, completion: nil)
            completionHandler(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .red
        
        //Edit
        let editAction = UIContextualAction(style: .normal, title:  "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("editou")
            
            success(true)
        })
        
        editAction.backgroundColor = UIColor(named: "Color3Secondary")
        editAction.image = UIImage(systemName: "pencil")
        
        //Duplicate
        let duplicateAction = UIContextualAction(style: .normal, title:  "Duplicate", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            let cardSelected = self.cards![indexPath.row]
            
            let alert = UIAlertController(title: "Duplicate \(cardSelected.title ?? "") ?", message: "This will duplicate all the records in this card", preferredStyle: .alert)
            
            let alertCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(alertCancel)
            
            let alertSave = UIAlertAction(title: "Duplicate", style: .default) { (action) in
                  
    
                let newCard = duplicateCard(card: cardSelected)
                self.cards?.append(newCard)
                self.fetchData()
            }
            
            alert.addAction(alertSave)
            self.present(alert, animated: true, completion: nil)
            success(true)
        })
        
        duplicateAction.backgroundColor = UIColor(named: "Color4Secondary")
        duplicateAction.image = UIImage(systemName: "doc.on.doc")
        
        //swipe actions
        let swipe = UISwipeActionsConfiguration(actions:[ deleteAction, editAction, duplicateAction])
        
        return swipe
    }
    
}
