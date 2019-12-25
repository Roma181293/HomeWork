//
//  ViewController.swift
//  ДЗ 22 Roman Topchii iOS 19-2
//
//  Created by Roman Topchii on 25.12.2019.
//  Copyright © 2019 Roman Topchii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView1: UITableView!
    
    var emojis: [Emoji] = [
        Emoji(symbol: "😀", name: "Grinning Face", description: "A typical smiley face.", usage: "happiness"),
        Emoji(symbol: "😕", name: "Confused Face", description: "A confused, puzzled face.", usage: "unsure what to think; displeasure"),
        Emoji(symbol: "😍", name: "Heart Eyes",description: "A smiley face with hearts for eyes.",usage: "love of something; attractive"),
        Emoji(symbol: "👮", name: "Police Officer", description: "A police officer wearing a blue cap with a gold badge.", usage: "person of authority"),
        Emoji(symbol: "🐢", name: "Turtle", description: "A cute turtle.", usage: "Something slow"),
        Emoji(symbol: "🐘", name: "Elephant", description: "A gray elephant.", usage: "good memory"),
        Emoji(symbol: "🍝", name: "Spaghetti", description: "A plate of spaghetti.", usage: "spaghetti"),
        Emoji(symbol: "🎲", name: "Die", description: "A single die.", usage: "taking a risk, chance; game"),
        Emoji(symbol: "⛺️", name: "Tent", description: "A small tent.", usage: "camping"),
        Emoji(symbol: "📚", name: "Stack of Books", description: "Three colored books stacked on each other.", usage: "homework, studying"),
        Emoji(symbol: "💔", name: "Broken Heart", description: "A red, broken heart.", usage: "extreme sadness"),
        Emoji(symbol: "💤", name: "Snore", description: "Three blue \'z\'s.", usage: "tired, sleepiness"),
        Emoji(symbol: "🏁", name: "Checkered Flag", description: "A black-and-white checkered flag.", usage: "completion")]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    
        
    //передача параметра через segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 //       print("root", #function, segue.identifier, segue.destination)
        
        guard let selectedIndexPath = tableView1.indexPathForSelectedRow else {return}
        
        
        let detailVC = segue.destination as! DetailViewController
        detailVC.emoji = emojis[selectedIndexPath.row]
        
    }
    
    
    
    
    
    
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: "cell_1", for: indexPath)
        cell.textLabel?.text = "\(emojis[indexPath.row].symbol) \(emojis[indexPath.row].name)"
        cell.detailTextLabel?.text = "\(emojis[indexPath.row].description)"
        return cell
    }
    
    
    
    //MARK:  UITableViewDelegate
    //обработка действий пользователя
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Pressed emoji: \(emojis[indexPath.row])")
        
        //снимаем выделение с выбранной ячейки
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "DetailViewController_ID") as! DetailViewController
        vc.emoji = emojis[indexPath.row]
    }
    

}



