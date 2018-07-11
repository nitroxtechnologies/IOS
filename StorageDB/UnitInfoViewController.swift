//
//  UnitInfoViewController.swift
//  StorageDB
//
//  Created by Taehyoung Kim on 7/9/18.
//  Copyright © 2018 Taehyoung Kim. All rights reserved.
//

import UIKit

//extension UIImage {
//    func resized(withPercentage percentage: CGFloat) -> UIImage? {
//        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
//        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
//        defer { UIGraphicsEndImageContext() }
//        draw(in: CGRect(origin: .zero, size: canvasSize))
//        return UIGraphicsGetImageFromCurrentImageContext()
//    }
//    func resized(toWidth width: CGFloat) -> UIImage? {
//        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
//        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
//        defer { UIGraphicsEndImageContext() }
//        draw(in: CGRect(origin: .zero, size: canvasSize))
//        return UIGraphicsGetImageFromCurrentImageContext()
//    }
//}

class UnitInfoViewController: UIViewController {
    
    var unit:Unit?

    @IBOutlet weak var unitDim: UILabel!
    @IBOutlet weak var climateLabel: UILabel!
    @IBOutlet weak var climateImage: UIImageView!
    @IBOutlet weak var floorLabel: UILabel!
    @IBOutlet weak var floorImage: UIImageView!
    @IBOutlet weak var unitPrice: UILabel!
    var dataFilter = #imageLiteral(resourceName: "blank")
    override func viewDidLoad() {
        super.viewDidLoad()
        climateImage.translatesAutoresizingMaskIntoConstraints = false
        floorImage.translatesAutoresizingMaskIntoConstraints = false
        unitDim.text = unit?.name
        climateLabel.text = unit?.type
        
        if unit?.type == "Climate" {
            climateImage.image = #imageLiteral(resourceName: "climate")
        } else if unit?.type == "Parking" {
            climateImage.image = #imageLiteral(resourceName: "drive")
        } else {
            climateImage.image = #imageLiteral(resourceName: "blank")
        }
        floorLabel.text = unit?.floor
        if unit?.floor == "1" {
            floorImage.image = #imageLiteral(resourceName: "ground")
        } else {
            floorImage.image = #imageLiteral(resourceName: "elevator")
        }
        
        if unit?.price == "0.00" {
            unitPrice.text = "Price: N/A"
        } else {
            unitPrice.text = "Price: $" + (unit?.price)!
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
//        let size = image.size
//
//        let widthRatio  = targetSize.width  / size.width
//        let heightRatio = targetSize.height / size.height
//
//        // Figure out what our orientation is, and use that to form the rectangle
//        var newSize: CGSize
//        if(widthRatio > heightRatio) {
//            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
//        } else {
//            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
//        }
//
//        // This is the rect that we've calculated out and this is what is actually used below
//        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
//
//        // Actually do the resizing to the rect using the ImageContext stuff
//        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
//        image.draw(in: rect)
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        return newImage!
//    }
//

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
