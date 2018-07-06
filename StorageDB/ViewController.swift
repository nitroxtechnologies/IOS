//
//  ViewController.swift
//  StorageDB
//
//  Created by Taehyoung Kim on 7/5/18.
//  Copyright © 2018 Taehyoung Kim. All rights reserved.
//

import UIKit

struct Company: Decodable {
    let id: String
    let name: String
    let website: String
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var companyTable: UITableView!
    
    var companies = [Company]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        companyTable.delegate = self
        companyTable.dataSource = self
        
        let jsonUrl = "http://taehyoung.com/companies.php"
        let url = URL(string: jsonUrl)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {return}
            do {
                self.companies = try JSONDecoder().decode([Company].self, from: data)
//                print(self.companies)
//                self.companyTable.reloadData()
                //tableView.reloadData() must run in the main thread!
                DispatchQueue.main.async {
                    self.companyTable.reloadData()
                }
            } catch let jsonError {
                print("Error ", jsonError)
            }
           
        }.resume()
        
//        print(self.companies)
//        companyTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selected = companyTable.indexPathForSelectedRow
        // set the company to display for FacilityViewController
        if let index = selected {
            let facilityVC = segue.destination as! FacilityViewController
            facilityVC.companyToDisplay = companies[index.row]
        }
    }
    
    // MARK: UITableView delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.companies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = companyTable.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
        cell.textLabel?.text = self.companies[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToFacility", sender: self)
    }
    
}

