//
//  KMTextField.swift
//  Git Commander
//
//  Created by Kanyanta Mubanga on 23.10.2020.
//

import UIKit

class KMQuestionTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUpField()
    }
    
    
    
    private func setUpField() {
        backgroundColor         = UIColor(named: K.Colors.accentColor)
        layer.cornerRadius      = 10
        layer.borderWidth       = 0.2
        layer.borderColor       = UIColor(named: K.Colors.textAndIcons)?.cgColor
    }
}
