//
//  EditViewController.swift
//  ProjetoFichamento
//
//  Created by Eduarda Soares Serpa Camboim on 13/08/21.
//

import UIKit

class EditViewController: UIViewController, UITextViewDelegate, EditFoldersModalListViewControllerDelegate {
    
    func didSelectedCategory(category: Category) {
        self.selectedCategory = category
        print(category)
        folderButtonOutlet.setTitle(category.name, for: .normal)
    }
  
    //MARK: - Outlets and variables
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var folderButtonOutlet: UIButton!
    @IBOutlet weak var userNotes: UITextView!
    @IBOutlet weak var textFieldAuthor: UITextField!
    @IBOutlet weak var textFieldReference: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var statusButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var delete: UIButton!
    
    var readingStatus = ""
    var selectedCategory: Category?
    
    var card: Card?
    var category: Category?

    @IBAction func folderButton(_ sender: Any) {
        
        performSegue(withIdentifier: "edit-modal-folder", sender: nil)
    }
    //MARK: - Delete Button
    @IBAction func deleteButton(_ sender: Any) {
        delete(card: card!, category: category!)
    }
    
    func delete(card: Card, category: Category) {
        let alert = UIAlertController(title: "Delete \(self.card?.title ?? "") ?", message: "This will delete all the records in this card", preferredStyle: .alert)
        
        let alertCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(alertCancel)
        
        let alertSave = UIAlertAction(title: "Delete", style: .default) { (action) in

            
            removeCard(category: category, card: card)
         
            _ = self.navigationController?.popViewController(animated: true)
            
        }
        
        alert.addAction(alertSave)
        self.present(alert, animated: true, completion: nil)
    }
    //MARK: - Reading Status Button
    
    @IBOutlet weak var presentStatusButtonOutlet: UIButton!
    @IBAction func presentStatusButton(_ sender: Any) {
        
        let statusSheet = UIAlertController(title: "Choose your reading status:", message: nil, preferredStyle: .actionSheet)
        let statusOptions = ["Reading","Read","To Read"]
        
        for item in statusOptions {
            let setAction = UIAlertAction(title: "\(item)", style: .default) { (_) in
                self.readingStatus = item
                self.presentStatusButtonOutlet.setTitle(item, for: .normal)
            }
            statusSheet.addAction(setAction)
        }
        
        let alertCancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        statusSheet.addAction(alertCancelButton)
        self.present(statusSheet, animated: true, completion: nil)
    }
    
    //MARK: - Save button
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        let sucessAlert = UIAlertController(title: "Success", message: "Record saved!", preferredStyle: .alert)
        let errAlert = UIAlertController(title: "Error", message: "Record not saved!", preferredStyle: .alert)

        if let folder = selectedCategory {
            if textFieldTitle.text != "" {
                let _ = addCard(category: folder, cardAnotation: userNotes.text, cardAuthor: textFieldAuthor.text ?? "", cardDate: datePicker.date, cardIsFavorite: false, cardReference: textFieldReference.text ?? "", cardStatus: readingStatus, cardTitle: textFieldTitle.text ?? "")
                cleanPage()
                self.present(sucessAlert, animated: true, completion: nil)
                self.dismiss(animated: true, completion: nil)
            }
            else {
                self.present(errAlert, animated: true, completion: nil)
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            self.present(errAlert, animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK: - Clean Page
    func cleanPage() {
        textFieldReference.text = ""
        textFieldAuthor.text = ""
        textFieldTitle.text = ""
        readingStatus = ""
        userNotes.text = ""
        presentStatusButtonOutlet.setTitle("Status", for: .normal)
        datePicker.date = Date()
        selectedCategory = nil
        folderButtonOutlet.setTitle("Folder", for: .normal)
    }
    
//    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
//        cleanPage()
//    }
    
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        if let folder = selectedCategory {
            folderButtonOutlet.setTitle(folder.name, for: .normal)
        }
        
        textFieldReference.text = card?.reference
        textFieldAuthor.text = card?.author
        textFieldTitle.text = card?.title
        readingStatus = card?.status ?? "nao veio"
        userNotes.text = card?.anotations ?? "faiou"
        presentStatusButtonOutlet.setTitle(card?.status ?? "faio", for: .normal)
        datePicker.date = card?.date ?? Date()
        selectedCategory = category
        folderButtonOutlet.setTitle(category?.name, for: .normal)
        

        presentStatusButtonOutlet.layer.cornerRadius = 6
        delete.layer.cornerRadius = 6
        delete.layer.borderWidth = 1
        delete.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        
        userNotes.delegate = self
    }
    
    //MARK: - Delegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        if userNotes.textColor == UIColor.lightGray {
            userNotes.text = ""
            userNotes.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if userNotes.text.isEmpty {
            userNotes.text = "Write here your notes"
            userNotes.textColor = UIColor.lightGray
        }
    }
    
    //MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        statusButtonWidth.constant = view.frame.width - 60 - datePicker.frame.width
    }
    
    //MARK: - Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "edit-modal-folder" {
            let navController = segue.destination as? UINavigationController
            let destination = navController?.topViewController as? EditFoldersModalListViewController
            destination?.delegate = self
        }
    }
    
}
