//
//  AttachmentTableViewCell.swift
//  ProjetoFichamento
//
//  Created by Bárbara Araújo Paim  on 04/08/21.
//

import UIKit

class AttachmentTableViewCell: UITableViewCell {
    
    @IBOutlet var fileTitle: UILabel!
    
    @IBAction func buttonDelete(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
