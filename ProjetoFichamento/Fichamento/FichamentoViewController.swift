//
//  FichamentoViewController.swift
//  ProjetoFichamento
//
//  Created by Bárbara Araújo Paim  on 02/08/21.
//

import UIKit

class FichamentoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var attachmentItem: [Files]?
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
        return self.attachmentItem?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filesCell", for: indexPath) as! AttachmentTableViewCell
        let attachment = self.attachmentItem![indexPath.row]
        let person = family.person?.allObjects as? [Person]
        cell.titleLabel.text = family.name
        cell.subtitleLabel.text = String(person?[0].name ?? "ferrou-se")
        return cell
    }

}
