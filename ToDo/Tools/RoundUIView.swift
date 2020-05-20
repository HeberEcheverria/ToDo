//
//  RoundUIView.swift
//  ToDo
//
//  Created by Heber Echeverria on 5/19/20.
//  Copyright © 2020 Heber Echeverria. All rights reserved.
//

import Foundation
import UIKit
extension UIView {

    func roundCorners(corners:UIRectCorner, radius: CGFloat) {

        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer
        }
    }
}
