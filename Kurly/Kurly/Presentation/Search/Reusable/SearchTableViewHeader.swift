//
//  SearchTableViewHeader.swift
//  Kurly
//
//  Created by 김민 on 2022/11/30.
//

import UIKit

// MARK: - SearchTableViewHeader

class SearchTableViewHeader: UITableViewHeaderFooterView {
    
    // MARK: - identifier
    
    static let identifier = "SearchTableViewHeader"
    
    // MARK: - Life Cycles
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extension

extension SearchTableViewHeader {
    
    // MARK: - Layout Helper
    
    private func layout() {
        contentView.backgroundColor = .systemPink
    }
}
