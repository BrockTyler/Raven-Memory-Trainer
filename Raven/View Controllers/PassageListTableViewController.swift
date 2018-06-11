//
//  PassageListTableViewController.swift
//  Raven
//
//  Created by brock tyler on 6/11/18.
//  Copyright © 2018 Brock Tyler. All rights reserved.
//

import UIKit
import CoreData

class PassageListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var passageListTableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredPassages = [Passage]()
    
    static var practiceView: Bool = false
    
    var fetchedResultsController = NSFetchedResultsController<Passage>()
    
    override func viewDidLoad() {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            fetchedResultsController = {
                let fetchRequest: NSFetchRequest<Passage> = Passage.fetchRequest()
                let chronoSort = NSSortDescriptor(key: "creationDate", ascending: false, selector: #selector(NSString.localizedStandardCompare(_:)))
                fetchRequest.sortDescriptors = [chronoSort]
                
                return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
            }()
            
            do {
                try fetchedResultsController.performFetch()
            } catch {
                print("Error loading from core data: \(error.localizedDescription)")
            }
            PassageListTableViewController.practiceView = false
        }
        
        passageListTableView.delegate = self
        passageListTableView.dataSource = self
        
        super.viewDidLoad()
        setupSearchBar()
        self.hideKeyboardWhenTappedAround()
        setupViews()
        fetchedResultsController.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if segmentedControl.selectedSegmentIndex == 0 {
            fetchedResultsController = {
                let fetchRequest: NSFetchRequest<Passage> = Passage.fetchRequest()
                let chronoSort = NSSortDescriptor(key: "creationDate", ascending: false, selector: #selector(NSString.localizedStandardCompare(_:)))
                fetchRequest.sortDescriptors = [chronoSort]
                
                return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
            }()
            
            do {
                try fetchedResultsController.performFetch()
            } catch {
                print("Error loading from core data: \(error.localizedDescription)")
            }
            PassageListTableViewController.practiceView = false
        }
        
        passageListTableView.reloadData()
    }
    
    func setupViews() {
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        self.segmentedControl.tintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        self.segmentedControl.clipsToBounds = true
        self.segmentedControl.layer.cornerRadius = 0
        self.segmentedControl.layer.borderWidth = 1.0
        self.segmentedControl.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        self.searchBar.barTintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numRows = 0
        
        if searchBar.text != "" {
            numRows = filteredPassages.count
        } else {
            guard let sectionInfo = fetchedResultsController.sections?[section] else { return 0 }
            numRows = sectionInfo.numberOfObjects
        }
        
        return numRows
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "passageCell", for: indexPath) as? PassageTableViewCell else { return UITableViewCell() }
        
        if searchBar.text != "" {
            let filteredPassage = filteredPassages[indexPath.row]
            cell.passage = filteredPassage
        } else {
            let passage = fetchedResultsController.object(at: indexPath)
            cell.passage = passage
        }
        
        return cell
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let passage = fetchedResultsController.object(at: indexPath)
            PassageController.deletePassage(passage: passage)
            
            do {
                try fetchedResultsController.performFetch()
            } catch {
                print("Error loading from core data: \(error.localizedDescription)")
            }
            
            tableView.reloadData()
        }
    }
    
    @IBAction func segmentedControlTapped(_ sender: Any) {
        
        if segmentedControl.selectedSegmentIndex == 1 {
            
            fetchedResultsController = {
                let fetchRequest: NSFetchRequest<Passage> = Passage.fetchRequest()
                let alphaSort = NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
                fetchRequest.sortDescriptors = [alphaSort]
                
                return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
            }()
            
            do {
                try fetchedResultsController.performFetch()
            } catch {
                print("Error loading from core data: \(error.localizedDescription)")
            }
            PassageListTableViewController.practiceView = false
            passageListTableView.reloadData()
            
        } else if segmentedControl.selectedSegmentIndex == 2 {
            
            fetchedResultsController = {
                let fetchRequest: NSFetchRequest<Passage> = Passage.fetchRequest()
                let lastPractice = NSSortDescriptor(key: "practiceDate", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
                fetchRequest.sortDescriptors = [lastPractice]
                
                return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
            }()
            
            do {
                try fetchedResultsController.performFetch()
            } catch {
                print("Error loading from core data: \(error.localizedDescription)")
            }
            PassageListTableViewController.practiceView = true
            passageListTableView.reloadData()
            
        } else {
            
            fetchedResultsController = {
                let fetchRequest: NSFetchRequest<Passage> = Passage.fetchRequest()
                let chronoSort = NSSortDescriptor(key: "creationDate", ascending: false, selector: #selector(NSString.localizedStandardCompare(_:)))
                fetchRequest.sortDescriptors = [chronoSort]
                
                return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
            }()
            
            do {
                try fetchedResultsController.performFetch()
            } catch {
                print("Error loading from core data: \(error.localizedDescription)")
            }
            PassageListTableViewController.practiceView = false
            passageListTableView.reloadData()
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toPracticeVC" {
            
            if let destinationVC = segue.destination as? PracticeViewController,
                let index = passageListTableView.indexPathForSelectedRow {
                
                if searchBar.text != "" {
                    let filteredPassage = filteredPassages[index.row]
                    destinationVC.passage = filteredPassage
                } else {
                    let passage = fetchedResultsController.object(at: index)
                    destinationVC.passage = passage
                }
            }
        } else if segue.identifier == "toAddView" {
            guard segue.destination is AddViewController else { return }
        }
    }
    
    // MARK: - SearchBar Functions and Setup
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filterContent(searchText: self.searchBar.text!)
    }
    
    func filterContent(searchText: String) {
        
        filteredPassages.removeAll()
        
        guard let passages = fetchedResultsController.fetchedObjects else { return }
        
        filteredPassages = passages.filter{ ($0.title?.lowercased().contains(searchText.lowercased()))! }
        
        passageListTableView.reloadData()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredPassages.removeAll()
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.resignFirstResponder()
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        self.searchBar.placeholder = "Search by passage title..."
        searchBar.returnKeyType = .done
    }
}

extension PassageListTableViewController: NSFetchedResultsControllerDelegate {
    
    // tell the tableview I'm about to do a bunch of stuff, hold up.
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        passageListTableView.beginUpdates()
    }
    
    // tell the tableView I finish doing my stuff, you do your thing.
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        passageListTableView.endUpdates()
    }
    
    // I just created, read, updated, or deleted something
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            passageListTableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let oldIndexPath = indexPath else { return }
            passageListTableView.deleteRows(at: [oldIndexPath], with: .automatic)
        case.update:
            guard let oldIndexPath = indexPath else { return }
            passageListTableView.reloadRows(at: [oldIndexPath], with: .automatic)
        case.move:
            guard let oldIndexPath = indexPath,
                let newIndexPath = indexPath else { return }
            passageListTableView.moveRow(at: oldIndexPath, to: newIndexPath)
        }
    }
    
    // I just changed the number of sections
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        let indexSet = IndexSet(integer: sectionIndex)
        
        switch type {
        case .insert:
            passageListTableView.insertSections(indexSet, with: .automatic)
        case .delete:
            passageListTableView.deleteSections(indexSet, with: .automatic)
        default:
            return
        }
    }
}
