//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Trang Do on 10/12/22.
//

import UIKit
import Parse
import AlamofireImage

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var posts = [PFObject] ()
    var postLimit = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.fetchPost()
        getUserInfo()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumInteritemSpacing = 1
        
        let width = (collectionView.frame.self.width - layout.minimumInteritemSpacing * 2) / 3
        print("width: \(width)")
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = 1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.fetchPost()
        getUserInfo()
    }
    
    func getUserInfo() {
        let user = PFUser.current()
        usernameLabel.text = user?.username
        
        let imageFile = user!["profileImage"] as? PFFileObject
        let urlString = imageFile?.url! ?? "https://img.icons8.com/material/96/000000/name--v1.png"
        let url = URL(string: urlString)
        profileImage.af.setImage(withURL: url!)
        
    }
    
    func fetchPost() {
        let query = PFQuery(className: "Posts")
        query.whereKey("author", equalTo: PFUser.current()!)
        query.addDescendingOrder("createdAt")
        query.limit = postLimit
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileImageCell", for: indexPath) as! ProfileImageCell
        let post = posts[indexPath.row]
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
       
        cell.photoImage.af.setImage(withURL: url)
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
