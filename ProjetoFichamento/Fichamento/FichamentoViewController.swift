//
//  FichamentoViewController.swift
//  ProjetoFichamento
//
//  Created by Bárbara Araújo Paim  on 02/08/21.
//

import UIKit

class FichamentoViewController: UIViewController, UITableViewDataSource, UITabBarDelegate, UITableViewDelegate {
    
    @IBOutlet var textFieldTitle: UITextField!
    
    @IBOutlet var searchBarFolder: UISearchBar!
    
    @IBOutlet var textFieldText: UITextField!
    
    @IBOutlet var textFieldAuthor: UITextField!
    
    @IBOutlet var textFieldReference: UITextField!
    
    @IBAction func buttonStatus(_ sender: Any) {
    }
    
    
    // data button
    
    @IBAction func buttonAttachment(_ sender: Any) {
    }
    
    @IBOutlet var tableViewAttachments: UITableView!
    
    
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
