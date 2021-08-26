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
            return "Latest Search"
        case .currentSearch:
            return ""
        }
    }
}

class SearchViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var searchController: UISearchController!
    let searchSections = SearchCategory.allCases
    var folders: [Category]? = returnCategory()
    var filteredFolders: [Category] = []
    var latestsResearches: [Category] = []
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
        latestSearchTableView.separatorStyle = .none
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false

        navigationItem.searchController = searchController
        
        searchController.searchBar.placeholder = "Enter the folder name"
        //searchController.searchBar.showsSearchResultsButton = true
        
        latestSearchTableView.delegate = self
        latestSearchTableView.dataSource = self
        
        setuplatestSearchTableView()
        folders = returnCategory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        folders = returnCategory()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let typedText = searchController.searchBar.text
        else {
            return
        }
        
        let formattedTypedText = typedText.folding(options: .diacriticInsensitive, locale: .current).lowercased()
        //        filteredFolders.removeAll()
        //        DispatchQueue.main.async {
        //            self.latestSearchTableView.reloadData()
        //        }
        //        for folder in folders {
        //            if folder.folder.lowercased() == formattedTypedText {
        //                filteredFolders.append(folder)
        //                DispatchQueue.main.async {
        //                    self.latestSearchTableView.reloadData()
        //                }
        //            }
        //        }
        
        let filterFolders = folders?.filter({ folder in
            let formattedFolderName = folder.name?.folding(options: .diacriticInsensitive, locale: .current).lowercased()
            return (((formattedFolderName!.contains(formattedTypedText))))
        })
        
        self.filteredFolders = filterFolders!
        self.latestSearchTableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = #colorLiteral(red: 0.997836411, green: 0.402813971, blue: 0.3040129542, alpha: 1)
            if traitCollection.userInterfaceStyle == .light {
                headerView.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                DispatchQueue.main.async {
                                    self.latestSearchTableView.reloadData()
                                }
            } else {
                headerView.contentView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                DispatchQueue.main.async {
                                    self.latestSearchTableView.reloadData()
                                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentSection = searchSections[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "latestResultsCell", for: indexPath)
        switch currentSection {
        case .currentSearch:
            cell.backgroundView?.frame = cell.frame.offsetBy(dx: 10, dy: 10);
            cell.textLabel?.text = filteredFolders[indexPath.row].name
            cell.textLabel?.backgroundColor = #colorLiteral(red: 0.9861258864, green: 0.9276378155, blue: 0.9153859019, alpha: 1)
            cell.textLabel?.layer.cornerRadius = 6.0
            cell.textLabel?.layer.borderWidth = 1.0
            cell.textLabel?.layer.borderColor = #colorLiteral(red: 0.9301540256, green: 0.4405925274, blue: 0.3389047384, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 0.9301540256, green: 0.4405925274, blue: 0.3389047384, alpha: 1)
            
            cell.clipsToBounds = true
        case .latestResearch:
            cell.textLabel?.text = latestsResearches[indexPath.row].name
            cell.textLabel?.textColor = #colorLiteral(red: 0.548969686, green: 0.5490515828, blue: 0.548951745, alpha: 1)
            cell.textLabel?.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            cell.textLabel?.layer.borderWidth = 0
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let verticalPadding: CGFloat = 8

        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10    //if you want round edges
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentSection = searchSections[indexPath.section]
        switch currentSection {
        case .currentSearch:
            let selectedFolder = filteredFolders[indexPath.row]
            latestsResearches.insert(selectedFolder, at: 0)
            performSegue(withIdentifier: "FichamentoDetails", sender: selectedFolder)
            latestSearchTableView.reloadData()
        case .latestResearch:
            let selectedFolder = latestsResearches[indexPath.row]
            performSegue(withIdentifier: "FichamentoDetails", sender: selectedFolder)
            latestSearchTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FichamentoDetails" {
            guard let selectedFolder = sender as? Category else { return }
            let openDetail = segue.destination as? FichamentoListViewController
            openDetail?.category = selectedFolder
        }
    }
}
