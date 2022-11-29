//
//  RecommendSearchTableViewCell.swift
//  Kurly
//
//  Created by 김민 on 2022/11/29.
//

import UIKit

// MARK: - RecommendSearchTableViewCell

class RecommendSearchTableViewCell: UITableViewCell {

    // MARK: - Identifier
    
    static let identifier = "RecommendSearchTableViewCell"
    
    // MARK: - Life Cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extension

extension RecommendSearchTableViewCell {
    
    private func layout() {
        contentView.backgroundColor = .green
    }
}
