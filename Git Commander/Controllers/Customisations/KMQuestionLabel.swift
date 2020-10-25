//
//  KMLabel.swift
//  Git Commander
//
//  Created by Kanyanta Mubanga on 23.10.2020.
//

import UIKit

class KMQuestionLabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        super.drawText(in: rect.inset(by: insets))
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUpLabel()
    }
    

    private func setUpLabel() {
        
//        setConstraints()
        
        backgroundColor         = .none
        layer.cornerRadius      = 10
        layer.borderWidth       = 1
        layer.borderColor       = UIColor(named: K.Colors.textAndIcons)?.cgColor
        textColor               = UIColor(named: K.Colors.textAndIcons)
    }

//    func setConstraints() {
//
//
//
//
//    }
}
