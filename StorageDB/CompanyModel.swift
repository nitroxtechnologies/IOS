//
//  CompanyModel.swift
//  StorageDB
//
//  Created by Taehyoung Kim on 7/6/18.
//  Copyright © 2018 Taehyoung Kim. All rights reserved.
//

import UIKit

protocol CompanyModelDelegate {
    func itemsDownloaded(companies:[Company])
}

class CompanyModel: NSObject {
    
    var delegate:CompanyModelDelegate?
    
    func getItems() {
        // hit the web service url, download json data & parse it out to Company struct, notify view controller
        let serviceUrl = "http://taehyoung.com/companies.php"
        let url = URL(string: serviceUrl)
        
        if let url = url {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                if error == nil {
                    // data fetch success!
                    self.parseJSON(data: data!)
                } else {
                    // Error!
                }
            })
            
            // start task
            task.resume()
        }
    }
    
    func parseJSON(data:Data) {
        var companyArray = [Company]()
        // parse data into Company struck
        do {
            // parse json
            let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
            for j in jsonArray {
                // cast json result as dictionary
                let d = j as! [String:String]
                // create new company and append to company array
                let c = Company(name: d["name"]!, website: d["website"]!)
                companyArray.append(c)
            }
            
            // parse company array back to delegate
            delegate?.itemsDownloaded(companies: companyArray)
        } catch {
            print("error parsing JSON")
        }
    }
}

