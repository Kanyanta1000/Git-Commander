//
//  TopicCell.swift
//  Git Commander
//
//  Created by Kanyanta Mubanga on 15.10.2020.
//

import UIKit

class QuizCell: UITableViewCell {

    @IBOutlet weak var circleProgressView: UIView!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var numOfQuestionsLabel: UILabel!
    
    func configureQuizCell(quiz: Quiz) {
        
        topicLabel.text = quiz.title.uppercased()
        numOfQuestionsLabel.text = "\(quiz.questions.count) " + K.numOfQuestionsText
        self.accessoryType = .disclosureIndicator
        
        //setProgressCircle()

    }
    
    
    func setProgressCircle() {
        
        // drawing a circle
        let center = CGPoint(x: circleProgressView.bounds.midX, y: circleProgressView.bounds.midY)
        let circularPath = UIBezierPath(arcCenter: center, radius: 30, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)

        //track layer
        let trackLayer = CAShapeLayer()

        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 5
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        
        circleProgressView.layer.addSublayer(trackLayer)
        
        
        //progress layer
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 5
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeEnd = 0
        
        circleProgressView.layer.addSublayer(shapeLayer)
        
//        circleProgressView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        
        //Animating
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 1
        
        basicAnimation.duration = 1
        
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        shapeLayer.add(basicAnimation, forKey: nil)
    }
}
