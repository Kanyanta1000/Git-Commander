//
//  TopicTableViewController.swift
//  Git Commander
//
//  Created by Kanyanta Mubanga on 09.10.2020.
//

import UIKit


class TopicTableViewController: UITableViewController {
    
    let myQuizes = quizBank().quizes
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath)
        let quizTopics = Array(myQuizes.keys)
        cell.textLabel?.text = quizTopics[indexPath.row]
        
        return cell
    }
    
//    MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myQuizes.count
    }
    
//    MARK: - TableView Data Manipulation Methods
    
    
}
