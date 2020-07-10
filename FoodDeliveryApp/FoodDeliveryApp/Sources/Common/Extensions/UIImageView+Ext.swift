//
//  UIImageView+Ext.swift
//  FoodDeliveryApp
//
//  Created by Charlie on 10/7/20.
//  Copyright © 2020 C. All rights reserved.
//

import UIKit

extension UIImageView {
    public func imageFromURL(urlString: String) {

        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        activityIndicator.center = CGPoint(x: UIScreen.main.bounds.width/2, y: self.bounds.height/2)
        
        activityIndicator.startAnimating()
        if self.image == nil{
            self.addSubview(activityIndicator)
        }

        URLSession.shared.dataTask(with: NSURL(string: urlString.replacingOccurrences(of: " ", with: "%20"))! as URL, completionHandler: { (data, response, error) -> Void in

            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                activityIndicator.removeFromSuperview()
                self.image = image
            })

        }).resume()
    }
}
