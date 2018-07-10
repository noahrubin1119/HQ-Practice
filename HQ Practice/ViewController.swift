//
//  ViewController.swift
//  HQ Practice
//
//  Created by Noah Rubin on 7/10/18.
//  Copyright © 2018 Noah Rubin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var categories = ["General Knoledge" : 9, "Entertainment: Books" : 10, "Entertainment: Film" : 11, "Entertainment: Music" : 12, "Entertainment: Musicals & Theatres" : 13, "Entertainment: Television" : 14, "Entertainment: Video Games" : 15, "Entertainment: Board Games" : 16, "Science & Nature" : 17, "Science: Computers" : 18, "Science: Mathematics" : 19, "Mythology" : 20, "Sports" : 21, "Geography" : 22, "History" : 23, "Politics" : 24, "Art" : 25, "Celebrities" : 26, "Animals" : 27, "Vehicles" : 28, "Entertainment: Comics" : 29, "Science: Gadgets" : 30, "Entertainment: Cartoon & Animations" : 32]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryName = Array(categories.keys)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = String(categoryName[indexPath.row])
        cell.textLabel?.textColor = .white
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let categoryId = Array(categories.values)
        let dvc = segue.destination as! QuestionViewController
        let index = tableView.indexPathForSelectedRow?.row
        dvc.categoryId = categoryId[index!]
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

