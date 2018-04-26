//
//  DetailViewController.swift
//  Meme V2.0
//
//  Created by Guneet Garg on 29/03/18.
//  Copyright © 2018 Guneet Garg. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController:UIViewController {
    
    @IBOutlet weak var detailedImage: UIImageView!
    var meme: MemeStruct! = nil
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        detailedImage.image = meme.memedImage
        self.tabBarController?.tabBar.isHidden = true
    }
    
}
