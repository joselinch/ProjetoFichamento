//
//  FoldersListViewController.swift
//  ProjetoFichamento
//
//  Created by Eduarda Soares Serpa Camboim on 28/07/21.
//

import UIKit

//cell ID: title-detail
//cell ID: custom-folder

class FoldersListViewController: UIViewController, UITableViewDataSource {
   
    
    let cellSpacingHeight: CGFloat = 50

    
    @IBAction func addFolders(_ sender: Any) {
        let alert = UIAlertController(title: "New Folder", message: "Enter a name for this folder", preferredStyle: .alert)
        
        alert.addTextField()
        
//        let submitButton = UIAlertAction(title: "Add", style: .default) { (action) in
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
//        }
        
//        alert.addAction(submitButton)
        self.present(alert, animated: true, completion: nil)
    
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    private var pastas: [Dados] = mockData()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
      
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {

        return true

    }
    
    
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
            if editingStyle == UITableViewCell.EditingStyle.delete {
                tableView.reloadData()
            }
    
        }
    
//    func tableView(_ tableView: UITableView,  trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
//
//        //delete
//        let delete = UIContextualAction(style: .normal, title: "Delete"){(action,view,completionHandler) in
//            print("deletou")
//            completionHandler(true)
//        }
//
//        //swipe actions
//        let swipe = UISwipeActionsConfiguration(actions:[ delete])
//        return swipe
//    }
    
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


