//
//  UIImageView.swift
//  RedPandaAssigment
//
//  Created by Arslan Ahmad on 30/10/2022.
//

import Foundation
import Kingfisher

extension UIImageView {
    func loading() {
        var kf = self.kf
        kf.indicatorType = .activity
    }
}
