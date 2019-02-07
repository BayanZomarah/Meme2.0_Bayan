//
//  SentMemesViewController.swift
//  pickImage
//
//  Created by Bayan Zomarah on 11/29/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class SentMemesViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
     @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell1.cell.image = memes[indexPath.row].memedImage
        
        
        //TODO: Dequeue each cell, fill it with a photo, and return it
        return cell1
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        self.collectionView.reloadData()
    }

    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space:CGFloat = 5.0
        let dimension = (view.frame.size.width - (2*space)) / 2.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        // Do any additional setup after loading the view.
    }
    


}

extension SentMemesViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "DetailsS") as! Details
        controller.meme = memes[indexPath.row]

        navigationController?.pushViewController(controller, animated: true)
        

    }
}
