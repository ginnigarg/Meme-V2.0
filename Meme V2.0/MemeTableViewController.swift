//
//  MemeTableViewController.swift
//  Meme V2.0
//
//  Created by Guneet Garg on 30/03/18.
//  Copyright © 2018 Guneet Garg. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController:UITableViewController {

    var memes: [MemeStruct] {
        return (UIApplication.shared.delegate as! AppDelegate).meme
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = false
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addNewImage(_ sender: Any) {
        let meme1 = storyboard!.instantiateViewController(withIdentifier: "newImage")
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
        navigationController!.pushViewController(meme1, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    
    override func tableView(_ tableView: UITableView,  cellForRowAt indexPath: IndexPath)-> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! TableCell
        let meme = memes[indexPath.row]
        cell.tableCellImageView.image = meme.memedImage
        cell.tableCellLabel.text = meme.topText + " " + meme.bottomText
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController = storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let meme = memes[indexPath.row]
        nextViewController.meme = meme
        navigationController?.pushViewController(nextViewController, animated: true)
    }


    
}
