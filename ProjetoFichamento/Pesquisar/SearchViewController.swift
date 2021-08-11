//
//  SearchViewController.swift
//  ProjetoFichamento
//
//  Created by Julia Silveira de Souza on 10/08/21.
//

import UIKit

class ResultsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
    }
}

class SearchViewController: ViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    let searchController = UISearchController(searchResultsController: ResultsViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text
        else {
            return
        }
        let viewResults = searchController.searchResultsController as? ResultsViewController
        viewResults?.view.backgroundColor = .yellow
        
        print(text)
    }
}
