//
//  RankingCollectionViewCell.swift
//  Kurly
//
//  Created by 김민 on 2022/12/19.
//

import UIKit

import SnapKit
import Then

// MARK: - RankingCollectionViewCell

class RankingCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Component
    
    private let rankingLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .kurlyPurple
    }
    
    private let productNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
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

extension RankingCollectionViewCell {
    
    // MARK: - Layout
    
    private func setLayout() {
        contentView.addSubviews(rankingLabel, productNameLabel)
        
        rankingLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
        
        productNameLabel.snp.makeConstraints {
            $0.leading.equalTo(rankingLabel.snp.trailing).offset(15)
            $0.centerY.equalToSuperview()
        }
    }
    
    // MARK: - General

    func dataBind(rankingModel: RankingModel) {
        rankingLabel.text = rankingModel.ranking
        productNameLabel.text = rankingModel.productNmae
    }
}
