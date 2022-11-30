//
//  RecommendCollectionViewCell.swift
//  Kurly
//
//  Created by 김민 on 2022/11/30.
//

import UIKit


class RecommendCollectionViewCell: UICollectionViewCell {
    
    // MARK: - identifier
    
    static let identifier = "RecommendCollectionViewCell"
    
    // MARK: - UI Components
    
    private let productNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .kurlyPurple
    }
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
        setAttribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extension

extension RecommendCollectionViewCell {
    
    // MARK: - Layout Helper
    
    private func layout() {
        
        contentView.backgroundColor = .clear
        contentView.addSubview(productNameLabel)
        
        productNameLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    // MARK: - General Helper
    
    private func setAttribute() {
        contentView.backgroundColor = UIColor(red: 250/255, green: 243/255, blue: 255/255, alpha: 1)
        contentView.layer.cornerRadius = contentView.frame.height / 2.5
    }
    
    func dataBind(productName: String) {
        productNameLabel.text = productName
    }
}
