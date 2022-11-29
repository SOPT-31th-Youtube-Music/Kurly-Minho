//
//  SearchTableViewHeader.swift
//  Kurly
//
//  Created by 김민 on 2022/11/30.
//

import UIKit

// MARK: - SearchTableViewHeader

class SearchTableViewHeader: UIView {
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
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
        self.backgroundColor = .systemPink
    }
}
