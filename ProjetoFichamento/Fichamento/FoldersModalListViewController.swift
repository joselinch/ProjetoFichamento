//
//  FoldersModalListViewController.swift
//  ProjetoFichamento
//
//  Created by José Antônio Linch Burmann on 11/08/21.
//

import UIKit

protocol FoldersModalListViewControllerDelegate: AnyObject {
    func didSelectedCategory(category: Category)
}

class FoldersModalListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    weak var delegate: FoldersModalListViewControllerDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func createButton(_ sender: Any) {
        let alert = UIAlertController(title: "New Folder", message: "Enter a name for this folder", preferredStyle: .alert)
        
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
        // Do any additional setup after loading the view.
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
            delegate?.didSelectedCategory(category: pasta)
        }
        navigationController?.dismiss(animated: true, completion: nil)
    }

    
    
}
