//
//  Extension+View.swift
//  MovieKuy
//
//  Created by Raden Dimas on 21/05/22.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach{
            addSubview($0)
        }
    }
}

//extension UIImageView {
//    func circular() {
//        self.layer.cornerRadius = (self.frame.size.width / 2.0)
//        self.clipsToBounds = true
//        self.layer.masksToBounds = true
//    }
//}
