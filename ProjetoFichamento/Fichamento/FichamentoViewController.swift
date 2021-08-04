//
//  FichamentoViewController.swift
//  ProjetoFichamento
//
//  Created by Bárbara Araújo Paim  on 02/08/21.
//

import UIKit

class FichamentoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var textFieldTitle: UITextField!
    @IBOutlet var searchBarFolder: UISearchBar!
    @IBOutlet var textFieldText: UITextField!
    @IBOutlet var tableViewAttachments: UITableView!
    @IBOutlet var textFieldAuthor: UITextField!
    @IBOutlet var textFieldReference: UITextField!
    @IBAction func statusButton(_ sender: Any) {
    }
    
    @IBAction func dateButton(_ sender: Any) {
    }
    
    @IBAction func addAttachmentButton(_ sender: Any) {
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        tableViewAttachments.dataSource = self
        tableViewAttachments.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {

    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }

}
