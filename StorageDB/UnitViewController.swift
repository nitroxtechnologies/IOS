//
//  UnitViewController.swift
//  StorageDB
//
//  Created by Taehyoung Kim on 7/6/18.
//  Copyright © 2018 Taehyoung Kim. All rights reserved.
//

import UIKit

class UnitViewController: UIViewController {
    
    @IBOutlet weak var unitTable: UITableView!
    @IBOutlet weak var navItem: UINavigationItem!
    var facilityToDisplay:Facility?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navItem.title = facilityToDisplay?.name

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
