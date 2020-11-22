//
//  TopicCell.swift
//  Git Commander
//
//  Created by Kanyanta Mubanga on 15.10.2020.
//

import UIKit

class QuizCell: UITableViewCell {
    
    @IBOutlet weak var disclosureIndicator: UIButton!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var numOfQuestionsLabel: UILabel!
    
    let iconColor = UIColor(named: K.Colors.textAndIcons)
    let iconBGColors = [
        UIColor(named: K.Colors.tableIcon0),
        UIColor(named: K.Colors.tableIcon1),
        UIColor(named: K.Colors.tableIcon2),
        UIColor(named: K.Colors.tableIcon3),
        UIColor(named: K.Colors.tableIcon4),
        UIColor(named: K.Colors.tableIcon5)
    ]

    func configureQuizCell(quiz: Quiz?, cellRow: Int) {
        
        //icons
        iconView.backgroundColor         = iconBGColors[cellRow]
        iconView.layer.cornerRadius      = 10
        
            let iconImageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium, scale: .medium)
            iconView.image = UIImage(systemName: quiz?.icon ?? "", withConfiguration: iconImageConfig)


        //title and subtitle
        topicLabel.text = quiz?.title.uppercased() ?? K.noQuizesFoundText
        topicLabel.textColor = iconColor
        numOfQuestionsLabel.text = "\(quiz?.questions.count ?? 0) " + K.numOfQuestionsText

        //disclosure indicator
        let disclosureIndicatorConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .medium, scale: .medium)
        let rightArrow = UIImage(systemName: K.rightChevron, withConfiguration: disclosureIndicatorConfig)
        
        disclosureIndicator.setImage(rightArrow, for: .normal)
        disclosureIndicator.tintColor = iconColor
        disclosureIndicator.isUserInteractionEnabled = false
        
        
        let bottomBorder = CALayer()

        bottomBorder.frame = CGRect(x: 90, y: 89, width: self.contentView.frame.size.width, height: 0.4)
        bottomBorder.backgroundColor = UIColor(named: K.Colors.textAndIcons)?.cgColor
        self.contentView.layer.addSublayer(bottomBorder)
    }
}


