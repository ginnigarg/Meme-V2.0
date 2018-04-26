//
//  MemeCollectionViewController.swift
//  Meme V2.0
//
//  Created by Guneet Garg on 30/03/18.
//  Copyright © 2018 Guneet Garg. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController:UICollectionViewController{
    
    @IBOutlet weak var layoutFlow: UICollectionViewFlowLayout!
 
    var memes: [MemeStruct] {
        return (UIApplication.shared.delegate as! AppDelegate).meme
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = false
        self.collectionView?.reloadData()
    }
    
    @IBAction func addNewImage(_ sender: Any) {
        let meme1 = storyboard!.instantiateViewController(withIdentifier: "newImage")
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
        
        navigationController!.pushViewController(meme1, animated: true)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        let meme = memes[indexPath.row]
        cell.collectionCellImage.image = meme.memedImage
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let memeDetail = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let meme = memes[indexPath.row]
        memeDetail.meme = meme
        navigationController?.pushViewController(memeDetail, animated: true)
    }

    
}
