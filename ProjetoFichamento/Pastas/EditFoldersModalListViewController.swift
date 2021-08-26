//
//  EditFoldersModalListViewController.swift
//  ProjetoFichamento
//
//  Created by Eduarda Soares Serpa Camboim on 13/08/21.
//

import UIKit

protocol EditFoldersModalListViewControllerDelegate: AnyObject {
    func didSelectedCategory(category: Category)
}

class EditFoldersModalListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    weak var delegate: EditFoldersModalListViewControllerDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newFolderButton: UIButton!

    
    @IBAction func createButton(_ sender: Any) {
        let alert = UIAlertController(title: "New Folder", message: "Enter a name for this folder", preferredStyle: .alert)
        
        alert.view.tintColor = #colorLiteral(red: 0.9301540256, green: 0.4405925274, blue: 0.3389047384, alpha: 1)
        
        alert.addTextField(){ (textField) in
            textField.placeholder = "Enter a name"
        }
        
        let alertCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(alertCancel)
        
        let alertSave = UIAlertAction(title: "Save", style: .default) { (action) in
              let textField = alert.textFields![0]
            
            let name = textField.text
            addCategory(name: name ?? "")
            self.fetchData()
        }
        
        alert.addAction(alertSave)
        self.present(alert, animated: true, completion: nil)
    
    }
    
    private var pastas: [Category]?
    
    @IBAction func doneAction(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        newFolderButton.layer.cornerRadius = 6
    }
    
    func fetchData(){
        pastas = returnCategory()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pastas?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "list-folder", for: indexPath)
        
        cell.textLabel?.text = pastas?[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let pasta = pastas?[indexPath.row] {
            print(pasta)
            delegate?.didSelectedCategory(category: pasta)
        }
        navigationController?.dismiss(animated: true, completion: nil)
    }

    
}
