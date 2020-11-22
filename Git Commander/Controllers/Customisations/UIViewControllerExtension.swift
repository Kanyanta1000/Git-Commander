//
//  UIViewControllerExtension.swift
//  Git Commander
//
//  Created by Kanyanta Mubanga on 23.10.2020.
//

import Foundation
import UIKit

extension UIViewController {
    func setBackGround(bgImageView: UIImageView) {
        view.addSubview(bgImageView)
        view.sendSubviewToBack(bgImageView)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: K.Colors.darkPrimary)?.cgColor

        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        bgImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bgImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bgImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bgImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        bgImageView.image = UIImage(named: K.bgImage)
    }
}
