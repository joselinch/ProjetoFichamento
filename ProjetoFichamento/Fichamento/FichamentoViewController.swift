//
//  FichamentoViewController.swift
//  ProjetoFichamento
//
//  Created by Bárbara Araújo Paim  on 02/08/21.
//

import UIKit

class FichamentoViewController: UIViewController, FoldersModalListViewControllerDelegate {
    
    func didSelectedCategory(category: Category) {
        self.selectedCategory = category
    }
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var readingStatus = ""
    @IBOutlet var textFieldTitle: UITextField!
    @IBOutlet weak var statusButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var  datePicker: UIDatePicker!
    @IBOutlet var userNotes: UITextView!
    @IBOutlet var textFieldAuthor: UITextField!
    @IBOutlet var textFieldReference: UITextField!
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
//        let alertOkButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
//        sucessAlert.addAction(alertOkButton)
        print(selectedCategory?.name ?? "")
        self.present(sucessAlert, animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
        //performSegue(withIdentifier: "", sender: nil)
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
        //performSegue(withIdentifier: "", sender: nil)
    }
    
    override func viewDidLoad() {
        presentStatusButtonOutlet.layer.cornerRadius = 6.0
        presentStatusButtonOutlet.layer.borderWidth = 1
        presentStatusButtonOutlet.layer.cornerRadius = 6
        presentStatusButtonOutlet.layer.borderColor = UIColor(red: 0.929, green: 0.439, blue: 0.341, alpha: 1).cgColor
    }
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
    
}
