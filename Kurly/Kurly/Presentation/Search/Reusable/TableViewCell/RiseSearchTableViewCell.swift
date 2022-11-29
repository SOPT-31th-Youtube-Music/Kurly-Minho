//
//  RiseSearchTableViewCell.swift
//  Kurly
//
//  Created by 김민 on 2022/11/29.
//

import UIKit

// MARK: - RiseSearchTableViewCell

class RiseSearchTableViewCell: UITableViewCell {

    // MARK: - Identifier
    
    static let identifier = "RiseSearchTableViewCell"
    
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

extension RiseSearchTableViewCell {
    
    private func layout() {
        contentView.backgroundColor = .purple
    }
}
