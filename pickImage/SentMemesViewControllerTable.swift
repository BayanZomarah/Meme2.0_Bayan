//
//  SentMemesViewControllerTable.swift
//  pickImage
//
//  Created by Bayan Zomarah on 12/7/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class SentMemesViewControllerTable: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var TableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TCell", for: indexPath)
            as! TableViewCell
        cell.Tcell.image = memes[indexPath.row].memedImage
        cell.memeLabel?.text = "\(memes[indexPath.row].topText)  \(memes[indexPath.row].bottomText)"
        return cell
    }
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TableView.reloadData()
        tabBarController?.tabBar.isHidden = false
        navigationController?.isNavigationBarHidden = false
    }
    
   
}

extension SentMemesViewControllerTable: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 6
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "DetailsS") as! Details
        controller.meme = memes[indexPath.row]
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
   
}
