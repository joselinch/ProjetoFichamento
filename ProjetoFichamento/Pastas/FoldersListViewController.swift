//
//  FoldersListViewController.swift
//  ProjetoFichamento
//
//  Created by Eduarda Soares Serpa Camboim on 28/07/21.
//

import UIKit

//cell ID: title-detail
//cell ID: custom-folder

class FoldersListViewController: UIViewController, UITableViewDataSource {
   
    
    let cellSpacingHeight: CGFloat = 50

    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private var pastas: [Dados] = mockData()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        button.layer.cornerRadius = 6
        button.layer.borderColor = #colorLiteral(red: 0.8690773845, green: 0.5335876942, blue: 0.5460923314, alpha: 1)
        button.layer.borderWidth = 1.0
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return pastas.count
    } //retorna o número de pastas cadastradas
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let pasta = pastas[section]
        return pasta.folder.count
    } //Quantidade de linhas em uma sessão -> padrão 1 - define na func acima
    
// Set the spacing between sections
    private func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "title-detail", for: indexPath)

        let folders = pastas[indexPath.section]
        //configurar a célula
        cell.textLabel?.text = folders.folder
        
        cell.detailTextLabel?.text = folders.recordsNumber
        
        cell.layer.cornerRadius = 6
        
        //cell.clipsToBounds = true
        return cell
    } //Onde configuramos a célula mesmo
    

}
