//
//  DetalhesViewController.swift
//  ProjetoFichamento
//
//  Created by Eduarda Soares Serpa Camboim on 12/08/21.
//

import UIKit

extension UILabel{
    
    var heightForView: CGFloat {
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: bounds.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height
    }

}

class DetalhesViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var folderLabel: UILabel!
    @IBOutlet weak var textTextView: UITextView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var referenceLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    
    @IBAction func deleteButton(_ sender: Any) {
        delete(card: card!, category: category!)
    }
    
    var card: Card?
    var category: Category?
    var initialHeight: CGFloat?
    var initialContentViewHeight: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        button.layer.cornerRadius = 6.0
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        statusLabel.layer.cornerRadius = 6.0
        dateLabel.layer.cornerRadius = 6.0
        
        
        guard let card = card else { fatalError("Card is nil") }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        titleLabel.text = card.title
        folderLabel.text = category?.name
        textTextView.text = card.anotations
        authorLabel.text = card.author
        referenceLabel.text = card.reference
        statusLabel.text = card.status
        dateLabel.text = dateFormatter.string(from: card.date ?? Date())
        
        
        initialHeight = titleLabel.bounds.height + folderLabel.bounds.height + authorLabel.bounds.height + referenceLabel.bounds.height
        
        initialContentViewHeight = contentViewHeight.constant
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let initialHeight = initialHeight, let initialContentViewHeight = initialContentViewHeight else { return }
        let realHeight = titleLabel.heightForView + folderLabel.heightForView + authorLabel.heightForView + referenceLabel.heightForView
        
        let extraHeight = realHeight - initialHeight
        
        contentViewHeight.constant = initialContentViewHeight + extraHeight
        
    }
}
