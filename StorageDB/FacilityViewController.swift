//
//  FacilityViewController.swift
//  StorageDB
//
//  Created by Taehyoung Kim on 7/6/18.
//  Copyright © 2018 Taehyoung Kim. All rights reserved.
//

import UIKit

struct Facility: Decodable {
    let id: String
    let sourceURL: String
    let name: String
    let companyId: String
    let streetAddress1: String
    let streetAddress2: String
    let city: String
    let state: String
    let zip: String
    let country: String
    let website: String
    let setupFee: String?
    let percentFull: String?
    let hasRetailStore: String
    let hasInsurance: String
    let hasOnlineBillPay: String
    let hasWineStorage: String
    let hasKiosk: String
    let hasOnsiteManagement: String
    let hasCameras: String
    let hasVehicleParking: String
    let hasCutLocks: String
    let hasOnsiteShipping: String
    let hasAutopay: String
    let hasOnsiteCarts: String
    let hasParabolicMirrors: String
    let hasMotionLights: String
    let hasElectronicLease: String
    let hasPaperlessBilling: String
    let mondayOpen: String?
    let mondayClose: String?
    let tuesdayOpen: String?
    let tuesdayClose: String?
    let wednesdayOpen: String?
    let wednesdayClose: String?
    let thursdayOpen: String?
    let thursdayClose: String?
    let fridayOpen: String?
    let fridayClose: String?
    let saturadyOpen: String?
    let saturdayClose: String?
    let sundayOpen: String?
    let sundayClose: String?
    let rating : String
    let promotions: String
}

class FacilityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var facilityTable: UITableView!
    @IBOutlet weak var navItem: UINavigationItem!
    
    var companyToDisplay:Company?
    var facilities = [Facility]()
    var compareMode:Bool = false
    var compareFacility:Facility?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        facilityTable.delegate = self
        facilityTable.dataSource = self
        self.navItem.title = companyToDisplay?.name
        let jsonUrl = "http://taehyoung.com/facilities.php?id=" + (companyToDisplay?.id)!
        let url = URL(string: jsonUrl)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {return}
            do {
                self.facilities = try JSONDecoder().decode([Facility].self, from: data)
                //                self.companyTable.reloadData()
                //tableView.reloadData() must run in the main thread!
                DispatchQueue.main.async {
                    self.facilityTable.reloadData()
                }
            } catch let jsonError {
                print("Error ", jsonError)
            }
            
        }.resume()
    }
    
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        <#code#>
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if compareMode == true {
            self.compareMode = false
            let destination = segue.destination as! CompareViewController
            destination.facility = compareFacility
            // set the company to display for FacilityViewController
            let selected = facilityTable.indexPathForSelectedRow
            if let index = selected {
                destination.otherFacility = facilities[index.row]
            }
        } else {
            let selected = facilityTable.indexPathForSelectedRow
            // set the company to display for FacilityViewController
            if let index = selected {
                let unitsVC = segue.destination as! UnitViewController
                unitsVC.facilityToDisplay = facilities[index.row]
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.facilities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = facilityTable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.facilities[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if compareMode == true {
            performSegue(withIdentifier: "ShowCompareInfo", sender: self)
        } else {
            performSegue(withIdentifier: "GoToUnits", sender: self)
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
