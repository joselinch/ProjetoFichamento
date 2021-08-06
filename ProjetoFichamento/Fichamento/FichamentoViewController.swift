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
    var status: String = ""
    @IBOutlet var textFieldTitle: UITextField!
    @IBOutlet var searchBarFolder: UISearchBar!
    @IBOutlet var textFieldText: UITextField!
    @IBOutlet var tableViewAttachments: UITableView!
    @IBOutlet var textFieldAuthor: UITextField!
    @IBOutlet var textFieldReference: UITextField!
    
    //MARK: Reading Status
    @IBOutlet var presentStatusButtonOutlet: UIButton!
    @IBAction func presentStatusButton(_ sender: Any) {
        let statusSheet = UIAlertController(title: "Choose your reading status:", message: nil, preferredStyle: .actionSheet)
        let statusOptions = ["Reading","Read","To Read"]
        
        for item in statusOptions {
            let setAction = UIAlertAction(title: "\(item)", style: .default) { (_) in
                self.status = item
                self.presentStatusButtonOutlet.setTitle(item, for: .normal)
            }
            statusSheet.addAction(setAction)
        }
        
        let alertCancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        statusSheet.addAction(alertCancelButton)
        self.present(statusSheet, animated: true, completion: nil)
    }
    
    //MARK: Calendar Picker
    @IBOutlet var dateButtonOutlet: UIButton!
    @IBAction func dateButton(_ sender: Any) {
        print("Clica")
    }
    
    //MARK: Attachment Button
    @IBOutlet var attachmentButtonOutlet: UIButton!
    @IBAction func addAttachmentButton(_ sender: Any) {
        print("Funcionou")
    }
    
    @IBAction func saveButton(_ sender: Any) {
        //MARK: To do: alertar somente quando for feito o save do card com sucesso e adicionar o dismiss da tela para a tela de fichamentos
        let sucessAlert = UIAlertController(title: "Success", message: "Record saved!", preferredStyle: .alert)
        let alertOkButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        sucessAlert.addAction(alertOkButton)
        self.present(sucessAlert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        tableViewAttachments.dataSource = self
        tableViewAttachments.delegate = self
        
        presentStatusButtonOutlet.layer.cornerRadius = 6.0
        presentStatusButtonOutlet.layer.borderWidth = 1
        presentStatusButtonOutlet.layer.cornerRadius = 6
        presentStatusButtonOutlet.layer.borderColor = UIColor(red: 0.929, green: 0.439, blue: 0.341, alpha: 1).cgColor
        
        dateButtonOutlet.layer.cornerRadius = 6.0
        dateButtonOutlet.layer.borderWidth = 1
        dateButtonOutlet.layer.cornerRadius = 6
        dateButtonOutlet.layer.borderColor = UIColor(red: 0.929, green: 0.439, blue: 0.341, alpha: 1).cgColor
    }
    
    //MARK: Attachments TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filesCell", for: indexPath) as! AttachmentTableViewCell
        let attachment = self.attachmentItem![indexPath.row]
        cell.fileTitle.text = attachment.fileName
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.attachmentItem?.count ?? 0
    }
}
