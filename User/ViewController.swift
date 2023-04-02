//
//  ViewController.swift
//  User
//
//  Created by Mac on 12/03/23.
//

import UIKit
import SDWebImage
class ViewController: UIViewController {
    var userDetailVC = UserDetailViewController()
    @IBOutlet weak var usersTableView: UITableView!
    var users = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonParsing()
    }
   func tableView(){
       usersTableView.dataSource = self
       usersTableView.delegate = self
       let uinib=UINib(nibName: "UserTableViewCell", bundle: nil)
       self.usersTableView.register(uinib, forCellReuseIdentifier: "UserTableViewCell")
    }
    func jsonParsing(){
        let url = URL(string: "https://reqres.in/api/users?page=2")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        URLSession.shared.dataTask(with: urlRequest){data,response,error in
            print(response)
            print(String(data: data!,encoding: .utf8)!)
            let getjsonObject = try! JSONSerialization.jsonObject(with: data!) as! [String : Any]
            let jsonObjects = getjsonObject["data"] as! [[String : Any]]
            for eachdictionary in jsonObjects{
                let userID = eachdictionary["id"] as! Int
                let userName = eachdictionary["first_name"] as! String
                let userLastname = eachdictionary["last_name"] as! String
                let email = eachdictionary["email"] as! String
                let userAvatar = eachdictionary["avatar"] as! String
                
                let newUser = User(id: userID, email: email, first_name: userName, last_name: userLastname, avatar: userAvatar)
                self.users.append(newUser)
                DispatchQueue.main.async {
                    self.usersTableView.reloadData()
                }
            }
        }.resume()
    }

}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.usersTableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell
        cell!.id.text = "\(users[indexPath.row].id)"
        cell!.name.text = "Name: \(users[indexPath.row].first_name)"
        let urlString = users[indexPath.row].avatar
        let url = URL(string: urlString)
        cell?.img.sd_setImage(with: url)
        cell!.layer.cornerRadius = 25
        cell!.layer.borderWidth = 8
        cell?.layer.borderColor = .init(genericCMYKCyan: 6, magenta: 3, yellow: 1, black: 5, alpha: 2)
        
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
        userDetailVC.user = users[indexPath.row]
        navigationController?.pushViewController(userDetailVC, animated: true)
    }
}
