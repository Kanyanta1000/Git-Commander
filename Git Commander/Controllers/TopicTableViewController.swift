//
//  TopicTableViewController.swift
//  Git Commander
//
//  Created by Kanyanta Mubanga on 09.10.2020.
//

import UIKit


class TopicTableViewController: UITableViewController {
    
    let myQuizes = QuizBank().quizes
    var quizTopic: String?
    let bgImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundView = UIImageView(image: UIImage(named: K.bgImage))
        navigationItem.title = K.quizListTitle
        
        animateTableCells()

    }
    
    //    MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let quiz = myQuizes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.quizCellIdentifier, for: indexPath) as! QuizCell

        cell.configureQuizCell(quiz: quiz, cellRow: indexPath.row)
        
        return cell
    }
    
    //    MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myQuizes.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath) as! QuizCell
        quizTopic = cell.topicLabel.text
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: K.goToQuestion, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! QuizViewController
        
        destinationVC.quizTitle = quizTopic
    }
    
    //    MARK: - Other functions
    func animateTableCells() {
        let cells = tableView.visibleCells
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: view.frame.width, y: 0)
        }
        
        var delay = 0.5
//        for cell in cells {
//            UIView.animate(withDuration: 0.2, delay: delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
//                cell.transform = .identity
//            })
//            
//            delay += 0.15
//        }
        
    }
    
    
}
