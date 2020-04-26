//
//  RecentTableViewController.swift
//  Player_record
//
//  Created by ddcfv on 2020/4/21.
//  Copyright © 2020 ddcfv. All rights reserved.
//

import CoreData
import UIKit

class RecentTableViewController: UITableViewController,NSFetchedResultsControllerDelegate{
    
    static var tbView: UITableView!
    var player_recent_data:[UserplaylogData] = []
    var player_date:[Date] = []
    var fetchResultController:NSFetchedResultsController<User_Recent>!
    var music_name_dict: [Int : String] = [:]
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RecentTableViewController.tbView = tableView;
        getUserData()
        getMusicName()
//        let fetchRequest: NSFetchRequest<User_Recent> = User_Recent.fetchRequest()
//        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor]
//        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
//
//            let context = appDelegate.persistentContainer.viewContext
//            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
//            fetchResultController.delegate = self
//
//            do {
//                try fetchResultController.performFetch()
//                if let fetchedObjects = fetchResultController.fetchedObjects {
//                    player_recent_data = fetchedObjects
//                }
//            } catch {
//                print(error)
//            }
//        }
        //print(player_recent_data)
    }

    // MARK: - Table view data source

    //num of data
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    //cell controll
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath:
    IndexPath) -> UITableViewCell {
        let cellIdentifier = "Recent_cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RecentTableViewCell
        
        cell.music_name_Label.text = music_name_dict[Int(player_recent_data[indexPath.row].music_id)!]
        cell.score_Label.text = player_recent_data[indexPath.row].score
        cell.rank_Label.text = player_recent_data[indexPath.row].rank
        cell.level_Label.text = player_recent_data[indexPath.row].level
        return cell
        // #warning Incomplete implementation, return the number of rows
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return player_recent_data.count
    }

//    //action set
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
//            // Delete the row from the data store
//            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
//                let context = appDelegate.persistentContainer.viewContext
//                let resultToDelete = self.fetchResultController.object(at: indexPath)
//                context.delete(resultToDelete)
//                appDelegate.saveContext()
//                print("delete")
//            }
//
//            // Call completion handler with true to indicate
//            completionHandler(true)
//        }
//
//
//        // Customize the action buttons
//        deleteAction.backgroundColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
//        deleteAction.image = UIImage(named: "delete")
//        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
//
//        return swipeConfiguration
//    }
    
    //update table view
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.beginUpdates()
//    }
//
//
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        switch type {
//        case .insert:
//            if let newIndexPath = newIndexPath {
//                tableView.insertRows(at: [newIndexPath], with: .fade)
//            }
//        case .delete:
//            if let indexPath = indexPath {
//                tableView.deleteRows(at: [indexPath], with: .fade)
//            }
//        case .update:
//            if let indexPath = indexPath {
//                tableView.reloadRows(at: [indexPath], with: .fade)
//            }
//        default:
//            tableView.reloadData()
//        }
//
//        if let fetchedObjects = controller.fetchedObjects {
//            player_recent_data = fetchedObjects as! [User_Recent]
//        }
//    }
    
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//          tableView.endUpdates()
//      }
    
    //getPlaylogdata
    func getUserData() {
        let urlStr = "http://welcome-collin.asuscomm.com:3000/query?table=cm_user_playlog&card=07BC024F7788AC65"
        if let url = URL(string: urlStr) {
            // GET
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else if let response = response as? HTTPURLResponse,let data = data {
                    print("Status code: \(response.statusCode)")
                    let decoder = JSONDecoder()
                    if let UserplayData = try? decoder.decode([UserplaylogData].self, from: data) {
                                DispatchQueue.main.async{
                                    for log in UserplayData {
                                    self.player_recent_data.append(log)
                                }
                                    self.player_recent_data.sort(by: { $0.user_play_date > $1.user_play_date })
                                    self.tableView.reloadData()
                                }
                            }
                        }
                    }.resume()
        }
        else {
            print("Invalid URL.")
        }
    }
    
    func getMusicName(){
        // 透過路徑尋找URL
        let url = Bundle.main.url(forResource: "music_name", withExtension: "json")
        let content = try! String(contentsOf: url!)
//        print(content)
        let data = content.data(using: .utf8)!
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
            {
                for i in jsonArray{
                    let id = i["id"] as! Int
                    let name = i["name"] as? String
//                    print(id,name)
                    music_name_dict[id] = name
                }
            } else {
                print("bad json")
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //json struct
    struct UserplaylogData: Decodable {
        var music_id: String
        var score: String
        var is_clear: String
        var level:String
        var rank:String
        var user_play_date:String
    }
    
    //musicname json struct
    struct MusicNameData: Decodable {
            var id: String
            var name :String
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
