//
//  FichamentoViewController.swift
//  ProjetoFichamento
//
//  Created by Bárbara Araújo Paim  on 02/08/21.
//

import UIKit


class FichamentoViewController: UIViewController, FoldersModalListViewControllerDelegate, UITextViewDelegate {
    
    func didSelectedCategory(category: Category) {
        self.selectedCategory = category
        folderButtonOutlet.setTitle(category.name, for: .normal)
    }
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var readingStatus = ""
    @IBOutlet var textFieldTitle: UITextField!
    @IBOutlet weak var statusButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var  datePicker: UIDatePicker!
    @IBOutlet var userNotes: UITextView!
    @IBOutlet var textFieldAuthor: UITextField!
    @IBOutlet weak var folderButtonOutlet: UIButton!
    @IBOutlet var textFieldReference: UITextField!
    @IBOutlet weak var heightContent: NSLayoutConstraint!
    var selectedCategory: Category?
    
    //MARK: Reading Status Button
    @IBOutlet var presentStatusButtonOutlet: UIButton!
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
        //performSegue(withIdentifier: "", sender: nil)
    }
    
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
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        cleanPage()
        //self.dismiss(animated: true, completion: nil)
        //performSegue(withIdentifier: "", sender: nil)
    }
    
    override func viewDidLoad() {
        if let folder = selectedCategory {
            folderButtonOutlet.setTitle(folder.name, for: .normal)
        }
    
        presentStatusButtonOutlet.layer.cornerRadius = 6
        
        userNotes.delegate = self
        userNotes.text = "Write here your notes"
        userNotes.textColor = UIColor.lightGray
        
    }
    
    
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
//    override func viewWillAppear(_ animated: Bool) {
//        print("CARREGOU WILLAPPEAR")
//        if let folder = selectedCategory {
//            folderButtonOutlet.setTitle(folder.name, for: .normal)
//        }
//    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        statusButtonWidth.constant = view.frame.width - 60 - datePicker.frame.width
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "modal-folder" {
            let navController = segue.destination as? UINavigationController
            let destination = navController?.topViewController as? FoldersModalListViewController
            destination?.delegate = self
        }
    }
    
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        textFieldTitle.resignFirstResponder()
//        userNotes.resignFirstResponder()
//    }
    
//    func keyboardWasShown(notification: NSNotification) {
//        let info = notification.userInfo!
//        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
//
//        UIView.animate(withDuration: 0.1, animations: { () -> Void in
//            self.heightContent.constant = keyboardFrame.size.height + 20
//            print (self.heightContent.constant)
//        })
//    }
   
}
