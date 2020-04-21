//
//  ProfileViewController.swift
//  Player_record
//
//  Created by ddcfv on 2020/4/21.
//  Copyright © 2020 ddcfv. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, URLSessionDelegate {
    //UI Test Value
    
    var user_name:String!
    var user_rate:String!
    var user_count:String!
    var music:User_Recent!
    
    var userDataUrl = URL(string:"http://welcome-collin.asuscomm.com:3000/query?table=cm_user_data&card=07BC024F7788AC65")
    var url = "http://welcome-collin.asuscomm.com:3000/query?table=cm_user_data&card=07BC024F7788AC65"
    
    @IBOutlet var name_lab: UILabel!
    @IBOutlet var rate_lab: UILabel!
    @IBOutlet var count_lab: UILabel!
    
    func savaCoreData(){
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            music = User_Recent(context: appDelegate.persistentContainer.viewContext)
            music.name = "B.B.B"
            music.level = "EXH"
            music.rank = "S"
            music.score = "10000000"
            appDelegate.saveContext()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        name_lab.text = user_name
        rate_lab.text = user_rate
        count_lab.text = user_count
    }
    
    //getdata
    func getUserData() {
        let urlStr = "http://welcome-collin.asuscomm.com:3000/query?table=cm_user_data&card=07BC024F7788AC65"
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { (data, response , error) in
                let decoder = JSONDecoder()
                if let data = data, let userData = try?
                   decoder.decode([UserData].self, from: data){
                    print(userData[0])
                    print(userData[0].user_name)
                    for user in userData{
                        self.user_name = user.user_name
                        print(self.user_name!)
                        self.user_rate = user.player_rating
                        self.user_count = user.play_count
                    }
                    
                }
                else {
                    print("error")
                }
            }.resume()
        }
    }
    
    //json struct
    struct UserData: Decodable {
        var user_name: String
        var player_rating: String
        var play_count: String
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
