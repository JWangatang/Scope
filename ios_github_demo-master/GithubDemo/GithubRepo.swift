//
//  GithubRepo.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import Foundation
import AFNetworking

private let reposUrl = "https://api.github.com/search/repositories"
private let clientId: String? = nil
private let clientSecret: String? = nil

// Model class that represents a GitHub repository
class GithubRepo: CustomStringConvertible {

    var name: String?
    var ownerHandle: String?
    var ownerAvatarURL: String?
    var stars: Int?
    var forks: Int?
    var repoDescription: String?
    var createdAt: String?
    var updatedAt: String?
    var watchers: Int?
    var language: String?
    
    // Initializes a GitHubRepo from a JSON dictionary
    init(jsonResult: NSDictionary) {
        if let name = jsonResult["name"] as? String {
            self.name = name
        }
        
        if let stars = jsonResult["stargazers_count"] as? Int? {
            self.stars = stars
        }
        
        if let forks = jsonResult["forks_count"] as? Int? {
            self.forks = forks
        }
        
        if let owner = jsonResult["owner"] as? NSDictionary {
            if let ownerHandle = owner["login"] as? String {
                self.ownerHandle = ownerHandle
            }
            if let ownerAvatarURL = owner["avatar_url"] as? String {
                self.ownerAvatarURL = ownerAvatarURL
            }
        }
        if let repoDescription = jsonResult["description"] as? String?{
            self.repoDescription = repoDescription
        }
        
        if let language = jsonResult["language"] as? String?{
            self.language = language
        }
        
        if let createdAt = jsonResult["created_at"] as? String?{
            self.createdAt = formatDate(createdAt!)
        }
        
        if let updatedAt = jsonResult["updated_at"] as? String?{
            self.updatedAt = formatDate(updatedAt!)
        }
        
        if let watchers = jsonResult["watchers_count"] as? Int?{
            self.watchers = watchers
        }
        
    }
    
    func formatDate(date: String) -> String{
        let months : [String:String] = ["01": "January", "02": "February", "03": "March", "04": "April", "05": "May", "06": "June", "07": "July", "08": "August", "09":"September", "10":"October", "11":"November", "12": "Decemeber"]
        
        let year = date[date.startIndex...date.startIndex.advancedBy(3)]
        let month = date[date.startIndex.advancedBy(5)...date.startIndex.advancedBy(6)]
        let day = date[date.startIndex.advancedBy(8)...date.startIndex.advancedBy(9)]
        
        return months[month]! + " " + day + ", " + year
    }
    
    // Actually fetch the list of repositories from the GitHub API.
    // Calls successCallback(...) if the request is successful
    class func fetchRepos(settings: GithubRepoSearchSettings, successCallback: ([GithubRepo]) -> Void, error: ((NSError?) -> Void)?) {
        let manager = AFHTTPRequestOperationManager()
        let params = queryParamsWithSettings(settings)
        
        manager.GET(reposUrl, parameters: params, success: { (operation ,responseObject) -> Void in
            if let results = responseObject["items"] as? NSArray {
                var repos: [GithubRepo] = []
                for result in results as! [NSDictionary] {
                    repos.append(GithubRepo(jsonResult: result))
                }
                successCallback(repos)
            }
        }, failure: { (operation, requestError) -> Void in
            if let errorCallback = error {
                errorCallback(requestError)
            }
        })
    }
    
    // Helper method that constructs a dictionary of the query parameters used in the request to the
    // GitHub API
    private class func queryParamsWithSettings(settings: GithubRepoSearchSettings) -> [String: String] {
        var params: [String:String] = [:];
        if let clientId = clientId {
            params["client_id"] = clientId;
        }
        
        if let clientSecret = clientSecret {
            params["client_secret"] = clientSecret;
        }
        
        var q = "";
        if let searchString = settings.searchString {
            q = q + searchString;
        }
        q = q + " stars:>\(settings.minStars)";
        params["q"] = q;
        
        params["sort"] = "stars";
        params["order"] = "desc";
        
        return params;
    }

    // Creates a text representation of a GitHub repo
    var description: String {
        var s: String = ""
        if (self.name != nil){
            s+="[Name: \(self.name!)]"
        }
        if(self.stars != nil){
            s+="\n\t[Stars: \(self.stars!)]"
        }
        if(self.forks != nil){
            s+="\n\t[Forks: \(self.forks!)]"
        }
        if(self.ownerHandle != nil){
            s+="\n\t[Owner: \(self.ownerHandle!)]"
        }
        if(self.ownerHandle != nil){
            s+="\n\t[Avatar: \(self.ownerAvatarURL!)]"
        }
        if(self.repoDescription != nil){
            s+="\n\t[Description: \(self.repoDescription!)]"
        }
        if(self.watchers != nil){
            s+="\n\t[Watchers Count: \(self.watchers!)]"
        }
        if(self.language != nil){
            s+="\n\t[Language: \(self.language!)]"
        }
        if(self.createdAt != nil){
            s+="\n\t[Created At: \(self.createdAt!)]"
        }
        if(self.updatedAt != nil){
            s+="\n\t[Updated At: \(self.updatedAt!)]"
        }
        return s;
        
        
    }
}