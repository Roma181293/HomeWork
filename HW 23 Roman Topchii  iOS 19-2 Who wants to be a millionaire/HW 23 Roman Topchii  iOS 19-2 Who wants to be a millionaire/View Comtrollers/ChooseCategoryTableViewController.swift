//
//  ChooseCategoryTableViewController.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 31.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit

class ChooseCategoryTableViewController: UITableViewController {
    
    var game : Game! = Game.share
    
    var categories : [Category] = []
    var images : [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        for category in categories {
            
            NetworkService.fetchImage(url: URL(string: category.imgURL)!) { (img, error) in
                DispatchQueue.main.async {
                    if let img = img{
                        self.images.append(img)
                        self.tableView.reloadData()
                    }
                }
            }
            
        }
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return categories.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chooseCell_ID", for: indexPath) as! CategoryTableViewCell
        
        if images.isEmpty == false && indexPath.row < images.count{
        cell.update(category: categories[indexPath.row], img : images[indexPath.row])
        }
        else {
            cell.update(category: categories[indexPath.row], img : UIImage(named: "load")!)
        }
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let questionVC = storyBoard.instantiateViewController(withIdentifier: "QuestionStoryboard_ID") as! QuestionViewController
        
        
        let url = URL(string: categories[indexPath.row].questionURL)!
        
        NetworkService.fetchQuestions(url: url) { (questions, error) in
            DispatchQueue.main.async {
                
                if let questions = questions {
                    self.game.newServerGame(questions: questions)
                    self.navigationController?.pushViewController(questionVC, animated: true)
                }
                
                
            }
            
        }
    }
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        //        guard let selectedIndexPath = tableView.indexPathForSelectedRow else {return}
        
        
    }
    */
    
}
