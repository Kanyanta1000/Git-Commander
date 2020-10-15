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
        let quiz = myQuizes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.quizCellIdentifier, for: indexPath) as! QuizCell
        
        cell.setQuizDetails(quiz: quiz)
        
        return cell
    }
    
    //    MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myQuizes.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath)
        quizTopic = cell?.textLabel?.text
        
        performSegue(withIdentifier: K.goToQuestion, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ViewController
        
        destinationVC.quizTitle = quizTopic
    }
    
    
}
