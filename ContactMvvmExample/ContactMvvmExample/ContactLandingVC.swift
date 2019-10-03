//
//  ContactLandingVC.swift
//  ContactMvvmExample
//
//  Created by Chandresh on 3/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
//
import UIKit
class ContactLandingVC: UIViewController {
    @IBOutlet weak var tableListView: UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            let searchController = UISearchController(searchResultsController: nil)
            navigationItem.hidesSearchBarWhenScrolling = false
            navigationItem.searchController = searchController
            navigationItem.searchController?.searchBar.delegate = self
            navigationItem.searchController?.searchBar.placeholder = "Search"
        }
        // Do any additional setup after loading the view.
    }
}
extension ContactLandingVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
       return 10
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell_Indentifier", for: indexPath)
        return cell
    }
}
/* Mark:- UITableViewDelegate */
extension ContactLandingVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) ->
        CGFloat {
            return 60
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: SectionHeaderView? = Bundle.main.loadNibNamed(SectionHeaderView.reuseIdentifier,
                                                                      owner: self,
                                                                      options: nil)?.first as? SectionHeaderView
        headerView?.lblHeaderTittle.text = "\(section)"
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}
extension ContactLandingVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.tableListView?.reloadData()
    }
}
