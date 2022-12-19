//
//  RecentCollectionReusableView.swift
//  Kurly
//
//  Created by 김민 on 2022/12/19.
//

import UIKit

import SnapKit
import Then

// MARK: - RecentCollectionHeaderView:

class RecentCollectionHeaderView: UICollectionReusableView {
    
    // MARK: - UI Component
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 17, weight: .semibold)
    }
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extension

extension RecentCollectionHeaderView {
    
    // MARK: - Layout
    
    private func setLayout() {
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
        }
    }
    
    // MARK: - General
    
    func dataBind(categoryName: String) {
        titleLabel.text = categoryName
    }
}
