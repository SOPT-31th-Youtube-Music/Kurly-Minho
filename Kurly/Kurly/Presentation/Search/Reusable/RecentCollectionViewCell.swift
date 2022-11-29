//
//  RecentCollectionViewCell.swift
//  Kurly
//
//  Created by 김민 on 2022/11/30.
//

import UIKit

import SnapKit
import Then

// MARK: - RecentCollectionViewCell

class RecentCollectionViewCell: UICollectionViewCell {
    
    // MARK: - identifier
    
    static let identifier = "RecentCollectionViewCell"
    
    // MARK: - UI Components
    
    private let productNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .darkGray
    }
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extension

extension RecentCollectionViewCell {
    
    // MARK: - Layout Helper
    
    private func layout() {
        
        contentView.backgroundColor = .clear
        contentView.addSubview(productNameLabel)
        
        productNameLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        setAttribute()
    }
    
    // MARK: - General Helper
    
    private func setAttribute() {
        contentView.layer.borderColor = UIColor.systemGray5.cgColor
        contentView.layer.borderWidth = 1
        
        contentView.layer.cornerRadius = 14
    }
    
    func dataBind(productName: String) {
        productNameLabel.text = productName
    }
}
