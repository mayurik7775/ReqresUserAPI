//
//  UserDetailViewController.swift
//  User
//
//  Created by Mac on 12/03/23.
//

import UIKit
import SDWebImage
class UserDetailViewController: UIViewController {
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var img: UIImageView!
    var user:User?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        name.text = "Name : \(user!.first_name + " " + user!.last_name)"
        name.textAlignment = .justified
        id.text = "Id: \(String(user!.id))"
        email.text = "Email: \(String(user!.email))"
        let url = URL(string: user!.avatar)
        img.sd_setImage(with: url!)
        img.layer.cornerRadius = 18
        
    }
   
}
