//
//  UnitViewController.swift
//  StorageDB
//
//  Created by Taehyoung Kim on 7/6/18.
//  Copyright © 2018 Taehyoung Kim. All rights reserved.
//

import UIKit

struct Unit: Decodable {
    let id: String
    let name: String
    let type: String
    let width: String
    let depth: String
    let height: String?
    let floor: String
    let doorHeight: String?
    let doorWidth: String?
    let price: String?
}

struct CellData {
    let climate : UIImage?
    let floor : UIImage?
    let message : String?
    let priceText : String?
}

class UnitViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var filter: UISegmentedControl!
    @IBOutlet weak var unitTable: UITableView!
    @IBOutlet weak var navItem: UINavigationItem!
    var facilityToDisplay:Facility?
    var units = [Unit]()
    var data = [CellData]()
    var hiddenCells = [Int]()
    var dataFilter : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navItem.title = facilityToDisplay?.name
        unitTable.delegate = self
        unitTable.dataSource = self
        //        data = [CellData.init(climate: #imageLiteral(resourceName: "climate"), floor: #imageLiteral(resourceName: "elevator"), message: "Climate"), CellData.init(climate: #imageLiteral(resourceName: "blank"), floor: #imageLiteral(resourceName: "elevator"), message: "Non-Climate"), CellData.init(climate: #imageLiteral(resourceName: "climate"), floor: #imageLiteral(resourceName: "ground"), message: "Ground"), CellData.init(climate: #imageLiteral(resourceName: "drive"), floor: #imageLiteral(resourceName: "ground"), message: "Drive-Up")]
        
        self.unitTable.register(UnitCell.self, forCellReuseIdentifier: "UnitCell")
        self.unitTable.rowHeight = UITableViewAutomaticDimension
        self.unitTable.estimatedRowHeight = 50
        
        let jsonUrl = "http://taehyoung.com/units.php?id=" + (facilityToDisplay?.id)!
        let url = URL(string: jsonUrl)

        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {return}
            do {
                self.units = try JSONDecoder().decode([Unit].self, from: data)
                //                self.companyTable.reloadData()
                //tableView.reloadData() must run in the main thread!
                
                for unit in self.units {
                    var cImage : UIImage?
                    var fImage : UIImage?
                    if unit.floor == "1" {
                        fImage = #imageLiteral(resourceName: "ground")
                    } else {
                        fImage = #imageLiteral(resourceName: "elevator")
                    }
                    
                    if unit.type == "Climate" {
                        cImage = #imageLiteral(resourceName: "climate")
                    } else if unit.type == "Parking" {
                        cImage = #imageLiteral(resourceName: "drive")
                    } else {
                        cImage = #imageLiteral(resourceName: "blank")
                    }
                    self.data.append(CellData.init(climate: cImage, floor: fImage, message: unit.name, priceText: "$" + unit.price!))
                }
                
                DispatchQueue.main.async {
                    self.unitTable.reloadData()
                }
            } catch let jsonError {
                print("Error ", jsonError)
            }

        }.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func indexChanged(_ sender: Any) {
        switch filter.selectedSegmentIndex {
        case 0:
            print("All")
            dataFilter = 0
        case 1:
            print("Climate")
            dataFilter = 1
        case 2:
            print("Non-Climate")
            dataFilter = 2
        default:
            print("Default")
            dataFilter = 0
        }
        
        DispatchQueue.main.async {
            self.unitTable.reloadData()
        }
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selected = unitTable.indexPathForSelectedRow
        // set the company to display for FacilityViewController
        if let index = selected {
            let unitInfoVC = segue.destination as! UnitInfoViewController
            unitInfoVC.unit = units[index.row]
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = unitTable.dequeueReusableCell(withIdentifier: "UnitCell") as! UnitCell
        cell.floor = data[indexPath.row].floor
        cell.climate = data[indexPath.row].climate
        cell.message = data[indexPath.row].message
        cell.priceText = data[indexPath.row].priceText
        
        hiddenCells.removeAll() // show all cells by default
        
        if dataFilter == 1 {
            if cell.climate != #imageLiteral(resourceName: "climate") {
                cell.isHidden = true
                hiddenCells.append(indexPath.row)
            }
        } else if dataFilter == 2 {
            if cell.climate != #imageLiteral(resourceName: "blank") {
                cell.isHidden = true
                hiddenCells.append(indexPath.row)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = 50.0
        if self.hiddenCells.contains(indexPath.row) {
            height = 0.0
        }
        return height
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowUnitInfo", sender: self)
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
