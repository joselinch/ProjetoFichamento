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
        
        alert.addTextField(){ (textField) in
            textField.placeholder = "Enter a name"
        }
        
        let alertCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(alertCancel)
        
        let alertSave = UIAlertAction(title: "Save", style: .default) { (action) in
              let textField = alert.textFields![0]
            
            let name = textField.text
            addCategory(name: name)
            self.fetchData()
        }
        
        alert.addAction(alertSave)
        self.present(alert, animated: true, completion: nil)
    
    }

//MARK: - Outlet, variaveis, viewDidLoad() e fetchData()
   
    @IBOutlet weak var tableView: UITableView!
    
    private var pastas: [Category]?
    let cellSpacingHeight: CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        fetchData()
    }
    
    func fetchData(){
        pastas = returnCategory()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

//MARK: - Funções tableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    } //retorna o número de sessões
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pastas?.count ?? 0
    } //Quantidade de linhas em uma sessão (padrão 1 - define na func acima)
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "title-detail", for: indexPath) as! FoldersTableViewCell
         
//        let folders = pastas?[indexPath.section]
        let folders = pastas![indexPath.row]
        
        cell.titleLabel.text = folders.name
        let records = folders.card?.allObjects as? [Card]
        cell.detailLabel.text = "\(records?.count ?? 0) Records"
        fetchData()

        return cell
    } //Onde configuramos a célula mesmo
    
    
//MARK: - Swipe

    func tableView(_ tableView: UITableView,  trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
       
        //MARK: - Deletar
      
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){(action,view,completionHandler) in
            
            let folderSelected = self.pastas![indexPath.row]
            
            let alert = UIAlertController(title: "Delete \(folderSelected.name ?? "") ?", message: "This will delete all the records in this folder", preferredStyle: .alert)
            
            let alertCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(alertCancel)
            
            let alertSave = UIAlertAction(title: "Delete", style: .default) { (action) in
                  
    
                deleteCategory(category: folderSelected)
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
            
            let folderSelected = self.pastas![indexPath.row]
            
            let alert = UIAlertController(title: "Edit Folder", message: "Edit the name for this folder", preferredStyle: .alert)
            
            alert.addTextField(){ (textField) in
                textField.placeholder = "Enter a name"
                textField.text = folderSelected.name
            }
            
            let alertCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(alertCancel)
            
            let alertSave = UIAlertAction(title: "Save", style: .default) { (action) in
                  let textField = alert.textFields![0]
                
                let name = textField.text
                editCategory(category: folderSelected, categoryName: name ?? "")
                self.fetchData()
            }
            
            alert.addAction(alertSave)
            self.present(alert, animated: true, completion: nil)
            
            
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


