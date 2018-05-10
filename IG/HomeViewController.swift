//
//  HomeViewController.swift
//  IG
//
//  Created by Cory Dashiell on 3/7/18.
//  Copyright © 2018 Cory Dashiell. All rights reserved.
//

import UIKit
import Parse
import ParseLiveQuery

class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var logOutButton: UIBarButtonItem!
    @IBOutlet weak var composeButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [PFObject]!
    
    var refreshController = UIRefreshControl()
    
    
    
    
    
    
    
    @IBAction func loggedOut(_ sender: Any) {
        // Logout the current user
        PFUser.logOutInBackground(block: { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Successful loggout")
                // Load and show the login view controller
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    @IBAction func composePressed(_ sender: Any) {
//        self.performSegue(withIdentifier: "composeSegue", sender: nil)
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstaCell", for: indexPath) as! InstaCell
        let post = self.posts![indexPath.row]
        cell.instagramPost = post
        
        return cell
    }
    
    func refresh() {
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                // do something with the data fetched
                self.posts = posts
                self.tableView.reloadData()
            } else {
                // handle error
                print(error?.localizedDescription)
            }
        }
    }
    
    func pullToRefresh(_ refreshController: UIRefreshControl) {
        refresh()
        tableView.reloadData()
        refreshController.endRefreshing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // get selected cell
        let cell = sender as! UITableViewCell
        //Grab the index of the selected cell (if not nil)
        if let indexPath = tableView.indexPath(for: cell) {
            let post = posts[indexPath.row]
            
            // create segue controller
            let detailVC = segue.destination as! DetailViewController
            
            detailVC.posts = post
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshController.addTarget(self, action: #selector(MainViewController.pullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshController, at: 0)
        
        refresh()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
