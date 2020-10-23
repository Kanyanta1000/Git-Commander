//
//  KMTextField.swift
//  Git Commander
//
//  Created by Kanyanta Mubanga on 23.10.2020.
//

import UIKit

class KMAnswerTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUpField()
    }
    
    
    
    private func setUpField() {
//        backgroundColor         = 
        layer.cornerRadius      = 10
        layer.borderWidth       = 1
        layer.borderColor       = UIColor(named: K.Colors.textAndIcons)?.cgColor
        textColor               = UIColor(named: K.Colors.textAndIcons)
    }
}
