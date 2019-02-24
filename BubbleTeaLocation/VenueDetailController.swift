//
//  VenueDetailController.swift
//  BubbleTeaLocation
//
//  Created by Pasut Kittiprapas on 2/21/2562 BE.
//  Copyright © 2562 Pasut Kittiprapas. All rights reserved.
//

import Alamofire
import AlamofireImage
import UIKit

class VenueDetailController: UIViewController {

    var name : String?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.text = name
        Alamofire.request("https://img.purch.com/rc/300x200/aHR0cDovL3d3dy5saXZlc2NpZW5jZS5jb20vaW1hZ2VzL2kvMDAwLzA3Ny83MzUvb3JpZ2luYWwvbGF1Z2hpbmctZW1vamkuanBlZw==").responseImage(completionHandler: {
            res in
            self.imageView.image = res.result.value
        })
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
