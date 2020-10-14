//
//  TopicTableViewController.swift
//  Git Commander
//
//  Created by Kanyanta Mubanga on 09.10.2020.
//

import UIKit


class TopicTableViewController: UITableViewController {
    
    let myQuizes = quizBank().quizes
    var quizTopic: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //    MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath)
        
        
        cell.textLabel?.text = myQuizes[indexPath.row].title
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    //    MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myQuizes.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath)
        quizTopic = cell?.textLabel?.text
        
        performSegue(withIdentifier: "goToQuestion", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ViewController
        
        destinationVC.quizTitle = quizTopic
    }
    
    //    MARK: - TableView Data Manipulation Methods
    
    
}
