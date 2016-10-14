//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD

// Main ViewController
class RepoResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()

    var repos: [GithubRepo]!
    var selectedRow : Int!

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self

        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        // Perform the first search when the view controller first loads
        doSearch()
    }

    // Perform the search.
    private func doSearch() {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in
            self.repos=newRepos
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.reloadData()
            
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            }, error: { (error) -> Void in
                print(error)
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GitHubCell", forIndexPath: indexPath) as! GitHubTableViewCell
        
        //Set cell info here
        let repo : GithubRepo = repos[indexPath.row]
        cell.avatarImageView.image = UIImage(data: NSData(contentsOfURL: NSURL(string: repo.ownerAvatarURL!)!)!)
        cell.descriptionLabel.text = repo.repoDescription
        cell.nameLabel.text = repo.name
        cell.starsLabel.text = repo.stars?.description
        cell.forksLabel.text = repo.forks?.description
        cell.handleLabel.text = repo.ownerHandle
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "detailsSegue"){
            let dest = segue.destinationViewController as! DetailsViewController
            dest.repo = repos[tableView.indexPathForSelectedRow!.row]
        }
        else{
            let dest = segue.destinationViewController as! SettingsViewController
            dest.sliderValue = Float(searchSettings.minStars)
        }
    }
    
}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true;
    }

    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true;
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
    
}


