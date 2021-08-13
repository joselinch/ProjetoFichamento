//
//  SearchViewController.swift
//  ProjetoFichamento
//
//  Created by Julia Silveira de Souza on 10/08/21.
//

import UIKit

enum SearchCategory: CaseIterable {
    case currentSearch
    case latestResearch
    
    var description: String {
        switch self {
        case .latestResearch:
            return "Latest Research"
        case .currentSearch:
            return ""
        }
    }
}

class SearchViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var searchController: UISearchController!
    let searchSections = SearchCategory.allCases
    var folders: [Dados] = mockData()
    var filteredFolders: [Dados] = []
    var latestsResearches: [Dados] = []
    let latestSearchTableView = UITableView()
    
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
        latestSearchTableView.estimatedRowHeight = 45.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Enter the folder name"
        searchController.searchBar.showsSearchResultsButton = true
        latestSearchTableView.delegate = self
        latestSearchTableView.dataSource = self
        setuplatestSearchTableView()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let typedText = searchController.searchBar.text
        else {
            return
        }
        
        let formattedTypedText = typedText.folding(options: .diacriticInsensitive, locale: .current).lowercased()
        filteredFolders.removeAll()
        DispatchQueue.main.async {
            self.latestSearchTableView.reloadData()
        }
        
        for folder in folders {
            if folder.folder.lowercased() == formattedTypedText {
                filteredFolders.append(folder)
                DispatchQueue.main.async {
                    self.latestSearchTableView.reloadData()
                }
            }
        }
        
//        let filterFolders = folders.filter({ folder in
//            let formattedFolderName = folder.folder.folding(options: .diacriticInsensitive, locale: .current).lowercased()
//            print(formattedFolderName)
//            return formattedFolderName.contains(formattedTypedText)
//        })
        
        if let resultsController = searchController.searchResultsController as? SearchViewController {
            //resultsController.filteredFolders = filterFolders
            resultsController.latestSearchTableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return searchSections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let currentSection = searchSections[section]
        return currentSection.description
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let currentSection = searchSections[section]
        switch currentSection {
        case .currentSearch:
            return filteredFolders.count
        case .latestResearch:
            return latestsResearches.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentSection = searchSections[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "latestResultsCell", for: indexPath)
        switch currentSection {
        case .currentSearch:
            cell.textLabel?.text = filteredFolders[indexPath.row].folder
        case .latestResearch:
            cell.textLabel?.text = latestsResearches[indexPath.row].folder
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentSection = searchSections[indexPath.section]
        switch currentSection {
        case .currentSearch:
            let selectedFolder = filteredFolders[indexPath.row]
            latestsResearches.insert(selectedFolder, at: 0)
            // TODO: Passar pra tela de detalhes
            latestSearchTableView.reloadData()
        case .latestResearch:
            let selectedFolder = latestsResearches[indexPath.row]
        // TODO: Passar pra tela de detalhes
        }
    }
}
