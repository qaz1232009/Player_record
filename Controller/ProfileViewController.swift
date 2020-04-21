//
//  ProfileViewController.swift
//  Player_record
//
//  Created by ddcfv on 2020/4/21.
//  Copyright © 2020 ddcfv. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    //UI Test Value
    
    var user_name:String! = "SEELE"
    var user_rate:String! = "0.00"
    var user_count:String! = "2"
    var music:User_Recent!
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
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        name_lab.text = user_name
        rate_lab.text = user_rate
        count_lab.text = user_count
        self.savaCoreData()
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
