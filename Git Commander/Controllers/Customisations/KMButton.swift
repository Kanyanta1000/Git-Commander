//
//  KMButton.swift
//  Git Commander
//
//  Created by Kanyanta Mubanga on 23.10.2020.
//

import UIKit

class KMButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUpButton()
    }
    
    
    
    private func setUpButton() {
        setShadow()
        setTitleColor(UIColor(named: K.Colors.textAndIcons), for: .normal)
        
        backgroundColor         = UIColor(named: K.Colors.accentColor)
        layer.cornerRadius      = 10
        layer.borderWidth       = 0.2
        layer.borderColor       = UIColor(named: K.Colors.textAndIcons)?.cgColor
    }
    
    private func setShadow() {
        layer.shadowColor       = UIColor(named: K.Colors.darkPrimary)?.cgColor
        layer.shadowOffset      = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius      = 8
        layer.shadowOpacity     = 0.5
        clipsToBounds           = true
        layer.masksToBounds     = true
    }

}
