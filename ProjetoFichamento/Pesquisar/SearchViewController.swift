//
//  SearchViewController.swift
//  ProjetoFichamento
//
//  Created by Julia Silveira de Souza on 10/08/21.
//

import UIKit

class ResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let latestSearchTableView = UITableView()
    let filterCategory = [Category]()
    var latestSearch: [String] = []
    
    func setuplatestSearchTableView() {
        view.addSubview(latestSearchTableView)
        latestSearchTableView.register(UITableViewCell.self, forCellReuseIdentifier: "latestResultsCell")
        latestSearchTableView.allowsSelection = true
        latestSearchTableView.isUserInteractionEnabled = true
        latestSearchTableView.translatesAutoresizingMaskIntoConstraints = false
        latestSearchTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        latestSearchTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        latestSearchTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        latestSearchTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        latestSearchTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return latestSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "latestResultsCell", for: indexPath)
        cell.textLabel?.text = latestSearch[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setuplatestSearchTableView()
    }
}

class SearchViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {
    let searchController = UISearchController(searchResultsController: ResultsViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Enter the folder name"
        searchController.searchBar.showsSearchResultsButton = true
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
    
    }
    
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let typedText = searchController.searchBar.text
        else {
            return
        }
        let viewResults = searchController.searchResultsController as? ResultsViewController
        
        viewResults?.latestSearch.append(typedText)
        print(viewResults?.latestSearch ?? typedText)
        print(typedText)
    }
}
