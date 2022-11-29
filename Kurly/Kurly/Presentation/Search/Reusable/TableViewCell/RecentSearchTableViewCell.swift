//
//  RecentSearchTableViewCell.swift
//  Kurly
//
//  Created by 김민 on 2022/11/29.
//

import UIKit

import SnapKit
import Then

// MARK: - RecentSearchTableViewCell

class RecentSearchTableViewCell: UITableViewCell {

    // MARK: - Identifier
    
    static let identifier = "RecentSearchTableViewCell"
    
    
    // MARK: - Life Cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

