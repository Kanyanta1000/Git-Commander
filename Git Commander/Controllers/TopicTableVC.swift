//
//  TopicTableViewController.swift
//  Git Commander
//
//  Created by Kanyanta Mubanga on 09.10.2020.
//

import UIKit
import RealmSwift

class TopicTableVC: UITableViewController {
    
    let realm = try! Realm()
    var myQuizes: Results<Quiz>?
    var quizTopic: String?
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        setUpDB()
    }
    
    //    MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let quiz = myQuizes?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.quizCellIdentifier, for: indexPath) as! QuizCell
        cell.configureQuizCell(quiz: quiz, cellRow: indexPath.row)
        
        return cell
    }
    
    //    MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myQuizes?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath) as! QuizCell
        
        quizTopic = cell.topicLabel.text
        
        performSegue(withIdentifier: K.goToQuestion, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! QuizVC  
        
        var newQuiz = Quiz()
        
        if let indexPath = tableView.indexPathForSelectedRow {
            if let selectedQuiz = myQuizes?[indexPath.row] {
                newQuiz = selectedQuiz
            }
            
            destinationVC.currentQuiz = newQuiz
        }
        
    }
    
    //    MARK: - Data Manipulation Methods
    func setUpDB() {
        
        if realm.isEmpty {
            populateDB()
        }
        
        myQuizes = realm.objects(Quiz.self).sorted(byKeyPath: "title", ascending: true)
    }
    
    func populateDB() {
        let quizBank    = QuizBank()
        let quizes      = quizBank.quizDictionary

        for (quizTitle, questionArray) in quizes {
            
            let newQuiz = Quiz()
            
            newQuiz.title = quizTitle
            newQuiz.icon = quizBank.icons[quizTitle] ?? K.noIcon
            
            for question in questionArray {
                newQuiz.questions.append(question)
            }
            
            do {
                try realm.write {
                    realm.add(newQuiz)
                }
            } catch {
                print("Error adding quiz: \(error)")
            }
        }
    }
    
    //    MARK: - UI Functions
    func setUpUI() {
        
        tableView.backgroundView = UIImageView(image: UIImage(named: K.bgImage))
        tableView.backgroundView?.layer.borderWidth = 1
        tableView.backgroundView?.layer.borderColor = UIColor(named: K.Colors.darkPrimary)?.cgColor
        navigationItem.title = K.quizListTitle
        tableView.separatorColor = UIColor.clear
//        tableView.tableFooterView = UIView()
        
//        animateTableCells()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        animateTableCells()
    }
    
    func animateTableCells() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let cells = tableView.visibleCells
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: view.frame.width, y: 0)
        }
        var delay = 0.5
        for cell in cells {
            UIView.animate(withDuration: 0.2, delay: delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = .identity
            })
            delay += 0.15
        }
    }
}
