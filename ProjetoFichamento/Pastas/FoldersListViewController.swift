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
   
    
    let cellSpacingHeight: CGFloat = 50

    
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
    
    @IBOutlet weak var tableView: UITableView!
    
    private var pastas: [Dados] = mockData()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
      
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
         
        let folders = pastas[indexPath.section]
        
        cell.titleLabel.text = folders.folder
        cell.detailLabel.text = folders.recordsNumber

        return cell
    } //Onde configuramos a célula mesmo
    
    
    
    //teste 1
    func tableView(_ tableView: UITableView,  trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        
        //Delete
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){(action,view,completionHandler) in
            print("deletou")
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
        
        //swipe actions
        let swipe = UISwipeActionsConfiguration(actions:[ deleteAction, editAction])
        
        return swipe
    }
    
    
    
    
    //teste 2
//    func tableView(_ tableView: UITableView,
//                    leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
//     {
//         let editAction = UIContextualAction(style: .normal, title:  "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
//                 success(true)
//             })
//    editAction.backgroundColor = .blue
//
//             return UISwipeActionsConfiguration(actions: [editAction])
//     }
//
//     func tableView(_ tableView: UITableView,
//                    trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
//     {
//         let deleteAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
//             success(true)
//         })
//         deleteAction.backgroundColor = .red
//
//         return UISwipeActionsConfiguration(actions: [deleteAction])
//     }
//
    
    

}


