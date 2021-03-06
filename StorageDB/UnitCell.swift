//
//  UnitCell.swift
//  StorageDB
//
//  Created by Taehyoung Kim on 7/9/18.
//  Copyright © 2018 Taehyoung Kim. All rights reserved.
//

import Foundation
import UIKit

class UnitCell: UITableViewCell {
    var climate : UIImage?
    var floor : UIImage?
    var message : String?
    var priceText: String?
    
    var messageView : UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isSelectable = true
        textView.isUserInteractionEnabled = false
        textView.font = UIFont.systemFont(ofSize: 15)
        return textView
    }()
    
    var climateImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var floorImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var priceView : UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isSelectable = true
        textView.isUserInteractionEnabled = false
        textView.font = UIFont.systemFont(ofSize: 15)
        //        textView.font = UIFont(name: textView.font?.fontName, size: 18)
        return textView
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(messageView)
        self.addSubview(climateImageView)
        self.addSubview(floorImageView)
        self.addSubview(priceView)
        
        messageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        messageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        messageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        messageView.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        messageView.widthAnchor.constraint(equalToConstant: 125).isActive = true
        messageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        messageView.centerYAnchor.constraint(lessThanOrEqualTo: self.centerYAnchor).isActive = true
        
        climateImageView.leftAnchor.constraint(equalTo: self.messageView.rightAnchor).isActive = true
        climateImageView.rightAnchor.constraint(equalTo: self.floorImageView.leftAnchor).isActive = true
        climateImageView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        climateImageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
//        climateImageView.centerXAnchor.constraint(lessThanOrEqualTo: self.centerXAnchor).isActive = true
        climateImageView.centerYAnchor.constraint(lessThanOrEqualTo: self.centerYAnchor).isActive = true
        
        
        floorImageView.leftAnchor.constraint(equalTo: self.climateImageView.rightAnchor).isActive = true
        floorImageView.rightAnchor.constraint(equalTo: self.priceView.leftAnchor).isActive = true
        floorImageView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        floorImageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
//        floorImageView.centerXAnchor.constraint(lessThanOrEqualTo: self.centerXAnchor).isActive = true
        floorImageView.centerYAnchor.constraint(lessThanOrEqualTo: self.centerYAnchor).isActive = true
        
        priceView.leftAnchor.constraint(equalTo: self.floorImageView.rightAnchor).isActive = true
        priceView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        priceView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        priceView.textAlignment = NSTextAlignment.right
        //        messageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        priceView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        priceView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        priceView.centerYAnchor.constraint(lessThanOrEqualTo: self.centerYAnchor).isActive = true
        
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let message = message {
            messageView.text = message
        }
        if let climate = climate {
            climateImageView.image = climate
        }
        if let floor = floor {
            floorImageView.image = floor
        }
        
        if let priceText = priceText {
            priceView.text = priceText
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
