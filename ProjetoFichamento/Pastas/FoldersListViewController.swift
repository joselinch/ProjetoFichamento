//
//  FoldersListViewController.swift
//  ProjetoFichamento
//
//  Created by Eduarda Soares Serpa Camboim on 28/07/21.
//

import UIKit

//cell ID: title-detail
//cell ID: custom-folder

class FoldersListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
//MARK: - Add folder
    @IBAction func addFolders(_ sender: Any) {
        let alert = UIAlertController(title: "New Folder", message: "Enter a name for this folder", preferredStyle: .alert)
        
//        alert.addTextField(){ (textField) in
//            textField.placeholder = "Enter a icon"
//            //textField.keyboardType = .numberPad
//        }
//
        alert.addTextField(){ (textField) in
            textField.placeholder = "Enter a name"
        }
        
        let alertCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(alertCancel)
        let alertSave = UIAlertAction(title: "Save", style: .default) { (action) in
//            let textField = alert.textFields![0]
//
//            let newPerson = Person(context: self.context)
//            newPerson.name = textField.text
//            newPerson.age = 20
//            newPerson.gender = "Female"
//
//            do {
//                try self.context.save()
//            }
//            catch {
//
//            }
//
//            self.fetchData()
        }
        
        alert.addAction(alertSave)
        self.present(alert, animated: true, completion: nil)
    
    }

//MARK: - Outlet, variaveis, viewDidLoad() e fetchData()
   
    @IBOutlet weak var tableView: UITableView!
    
    var category: Category?
    var cards: [Card]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        cards = category?.card?.allObjects as? [Card]
        navbarTitle.title = category?.name
        self.tableView.reloadData()
        
    }

    func fetchData() {
        cards = category?.card?.allObjects as? [Card]
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return pastas.count
    } //retorna o número de pastas cadastradas
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let pasta = pastas[section]
        return pasta.folder.count
    } //Quantidade de linhas em uma sessão -> padrão 1 - define na func acima
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    

        let cell = tableView.dequeueReusableCell(withIdentifier: "title-detail", for: indexPath) as! FoldersTableViewCell
         
        let cell = tableView.dequeueReusableCell(withIdentifier: "title-fichamento", for: indexPath) as! FichamentosTableViewCell
        

        let card = cards?[indexPath.row]
        
        cell.titleLabel.text = card?.title

        return cell
    } //Onde configuramos a célula mesmo
    
    
//MARK: - Swipe

    func tableView(_ tableView: UITableView,  trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
       
        //MARK: - Deletar
      
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){(action,view,completionHandler) in
            
            let cardSelected = self.cards![indexPath.row]
            
            let alert = UIAlertController(title: "Delete \(cardSelected.title ?? "") ?", message: "This will delete all the records in this folder", preferredStyle: .alert)
            
            let alertCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(alertCancel)
            
            let alertSave = UIAlertAction(title: "Delete", style: .default) { (action) in

                
                removeCard(category: self.category!, card: cardSelected)
             
                self.fetchData()
            }
            
            alert.addAction(alertSave)
            self.present(alert, animated: true, completion: nil)
            completionHandler(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .red
        
        //MARK: - Editar
        let editAction = UIContextualAction(style: .normal, title:  "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("editou")
            
            success(true)
        })
        
        editAction.backgroundColor = UIColor(named: "Color3Secondary")
        editAction.image = UIImage(systemName: "pencil")
        
        //swipe actions
        let swipe = UISwipeActionsConfiguration(actions:[ deleteAction, editAction])
        
        return swipe
    }

//MARK: - Segue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        func retornaValores() -> (senderCards: [Card], senderCategory: Category?) {
            return (pastas?[indexPath.row].card?.allObjects as! [Card], pastas?[indexPath.row])
        }
        performSegue(withIdentifier: "segueCards", sender: retornaValores())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueCards", let indexPath = sender as? (senderCards: [Card], senderCategory: Category?){
            let destination = segue.destination as? FichamentoListViewController
            destination?.cards = indexPath.senderCards
            destination?.category = indexPath.senderCategory
            
        }
    }

}


