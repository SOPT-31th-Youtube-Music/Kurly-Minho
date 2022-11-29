//
//  UIVIew+.swift
//  Kurly
//
//  Created by 김민 on 2022/11/29.
//

import UIKit

extension UIView{
    func addSubviews(_ views: UIView...){
        views.forEach { self.addSubview($0) }
    }
}
