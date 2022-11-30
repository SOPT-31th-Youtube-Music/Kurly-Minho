//
//  Adjusted.swift
//  Kurly
//
//  Created by saint on 2022/11/29.
//
import UIKit

extension Int {
    var adjusted: CGFloat {
        let ratio: CGFloat = CGFloat(UIScreen.main.bounds.width) / 375
        let ratioH: CGFloat = CGFloat(UIScreen.main.bounds.height) / 812
        return ratio <= ratioH ? CGFloat(self) * ratio : CGFloat(self) * ratioH
    }
}

extension Double {
    var adjusted: CGFloat {
        let ratio: CGFloat = CGFloat(UIScreen.main.bounds.width) / 375
        let ratioH: CGFloat = CGFloat(UIScreen.main.bounds.height) / 812
        return ratio <= ratioH ? CGFloat(self) * ratio : CGFloat(self) * ratioH
    }
}
