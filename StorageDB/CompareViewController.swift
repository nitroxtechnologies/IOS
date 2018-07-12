//
//  CompareViewController.swift
//  StorageDB
//
//  Created by Taehyoung Kim on 7/12/18.
//  Copyright © 2018 Taehyoung Kim. All rights reserved.
//

import UIKit

struct CompareCellData {
    let climate : UIImage?
    let climateText : String?
    let floor : UIImage?
    let floorText : String?
    let message : String?
    let priceText : String?
    var compareText : String?
}

class CompareViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var facility:Facility?
    var otherFacility:Facility?
    var data = [CompareCellData]()
    var unitsA = [Unit]()
    var unitsB = [Unit]()
    var dataFilter : Int?
    var hiddenCells = [Int]()
    
    
    @IBOutlet weak var compareTable: UITableView!
    @IBOutlet weak var navItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        compareTable.delegate = self
        compareTable.dataSource = self
        
        self.navItem.title = (facility?.name)! + " vs. " + (otherFacility?.name)!
        self.compareTable.register(CompareCell.self, forCellReuseIdentifier: "CompareCell")
        print(facility?.name)
        print(otherFacility?.name)
        
        self.compareTable.rowHeight = UITableViewAutomaticDimension
        self.compareTable.estimatedRowHeight = 50
        
        var jsonUrl = "http://taehyoung.com/units.php?id=" + (facility?.id)!
        var url = URL(string: jsonUrl)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {return}
            do {
                self.unitsA = try JSONDecoder().decode([Unit].self, from: data)
                //                self.companyTable.reloadData()
                //tableView.reloadData() must run in the main thread!
                
                for unit in self.unitsA {
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
                    var price : String?
                    if unit.price == "0.00" {
                        price = "N/A"
                    } else {
                        price = "$" + unit.price!
                    }
                    
                    self.data.append(CompareCellData.init(climate: cImage, climateText: unit.type, floor: fImage, floorText: unit.floor, message: unit.name, priceText: price!, compareText: ""))
                }
                
                DispatchQueue.main.async {
                    self.compareTable.reloadData()
                }
            } catch let jsonError {
                print("Error ", jsonError)
            }
            
            }.resume()
    
        jsonUrl = "http://taehyoung.com/units.php?id=" + (otherFacility?.id)!
        url = URL(string: jsonUrl)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {return}
            do {
                self.unitsB = try JSONDecoder().decode([Unit].self, from: data)
                //                self.companyTable.reloadData()
                //tableView.reloadData() must run in the main thread!
                for (i,d) in self.data.enumerated() {
                    for e in self.unitsB {
                        if d.climateText == e.type && d.floorText == e.floor && d.message == e.name {
                            if e.price != "0.00" {
                                self.data[i].compareText = "$" + e.price!
                            }
                        }
                    }
                }
//                for unit in self.unitsA {
//                    var cImage : UIImage?
//                    var fImage : UIImage?
//                    if unit.floor == "1" {
//                        fImage = #imageLiteral(resourceName: "ground")
//                    } else {
//                        fImage = #imageLiteral(resourceName: "elevator")
//                    }
//
//                    if unit.type == "Climate" {
//                        cImage = #imageLiteral(resourceName: "climate")
//                    } else if unit.type == "Parking" {
//                        cImage = #imageLiteral(resourceName: "drive")
//                    } else {
//                        cImage = #imageLiteral(resourceName: "blank")
//                    }
//                    self.data.append(CompareCellData.init(climate: cImage, floor: fImage, message: unit.name, priceText: "$" + unit.price!, compareText: "5"))
//                }
                
                DispatchQueue.main.async {
                    self.compareTable.reloadData()
                }
            } catch let jsonError {
                print("Error ", jsonError)
            }
            
            }.resume()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = compareTable.dequeueReusableCell(withIdentifier: "CompareCell") as! CompareCell
        cell.floor = data[indexPath.row].floor
        cell.climate = data[indexPath.row].climate
        cell.message = data[indexPath.row].message
        cell.priceText = data[indexPath.row].priceText
        cell.compareText = data[indexPath.row].compareText

//        hiddenCells.removeAll() // show all cells by default
//
//        if dataFilter == 1 {
//            if cell.climate != #imageLiteral(resourceName: "climate") {
//                cell.isHidden = true
//                hiddenCells.append(indexPath.row)
//            }
//        } else if dataFilter == 2 {
//            if cell.climate != #imageLiteral(resourceName: "blank") && cell.climate != #imageLiteral(resourceName: "drive"){
//                cell.isHidden = true
//                hiddenCells.append(indexPath.row)
//            }
//        }
        return cell
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
