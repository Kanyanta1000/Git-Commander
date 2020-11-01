//
//  KMLabel.swift
//  Git Commander
//
//  Created by Kanyanta Mubanga on 28.10.2020.
//

import UIKit

class KMLabel: UILabel {

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
        layer.backgroundColor   = UIColor(named: K.Colors.textAndIcons)?.cgColor
        layer.cornerRadius      = 10
        layer.masksToBounds     = true
        layer.borderColor       = UIColor(named: K.Colors.textAndIcons)?.cgColor
        textColor               = UIColor(named: K.Colors.textAndIcons)
    }
}
