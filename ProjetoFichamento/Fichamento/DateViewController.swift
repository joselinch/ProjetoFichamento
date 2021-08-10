//
//  DateViewController.swift
//  ProjetoFichamento
//
//  Created by Julia Silveira de Souza on 09/08/21.
//

import UIKit

class DateViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet var doneButton: UIBarButtonItem!
    @IBOutlet var cancelButton: UIBarButtonItem!
    @IBOutlet var datePicker: UIDatePicker!
    @IBAction func datePicker(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        datePicker.layer.cornerRadius = 6.0
        datePicker.layer.backgroundColor = UIColor(red: 0.976, green: 0.929, blue: 0.918, alpha: 1).cgColor
    }
    
}
