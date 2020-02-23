//
//  GameArchiveTableViewController.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 10.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit

class GameArchiveTableViewController: UITableViewController {
    
    var archive = Archive.share
    
    @IBOutlet var archiveTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = true
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //         self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 245.0/255.0, green: 242/255.0, blue: 240/255.0, alpha: 1)]
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = 80
        
        archive.readGameArchive()
    }
    
    
    @IBAction func clearArchive() {
        archive.clearAll()
        tableView.reloadData()
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return archive.count()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "archiveCell_ID", for: indexPath) as! ArchiveTableViewCell
        if let  info = archive.gameInfo(for: indexPath.row) {
            cell.update(date: info.date, memo: info.memo)
        }
        else {
            cell.update(date: "Sorry", memo: "Something going wrong!")
        }
        
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            archive.removeElement(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            archive.saveChanges()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        archive.moveTo(move: fromIndexPath.row, to: to.row)
        archive.saveChanges()
    }
    
    
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //получаем индекс нажатого элемента
        guard let selectedIndexPath = archiveTableView.indexPathForSelectedRow else {return}
        
        let vc : DetailViewController = segue.destination as! DetailViewController
        vc.gameResults = archive.gameResults(for: selectedIndexPath.row)
    }
    
    
}
