//
//  DetalhesViewController.swift
//  ProjetoFichamento
//
//  Created by Eduarda Soares Serpa Camboim on 12/08/21.
//

import UIKit

class DetalhesViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var folderLabel: UILabel!
    @IBOutlet weak var textTextView: UITextView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var referenceLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    @IBAction func deleteButton(_ sender: Any) {
    }
    
    var category: Category?
    var cards: [Card]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        button.layer.cornerRadius = 6.0
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        statusLabel.layer.cornerRadius = 6.0
        dateLabel.layer.cornerRadius = 6.0
        statusLabel.layer.cornerRadius = 6.0
        dateLabel.layer.cornerRadius = 6.0

        
        cards = category?.card?.allObjects as? [Card]

        
        titleLabel.text = "Teste"
        folderLabel.text = "teste"
        textTextView.text = "testestestetstestestetsetsetstest"
        authorLabel.text = "author teste"
        referenceLabel.text = "testetestestestetesteste"
        statusLabel.text = "Read"
        dateLabel.text = "12-08"
    }
    
    
}
