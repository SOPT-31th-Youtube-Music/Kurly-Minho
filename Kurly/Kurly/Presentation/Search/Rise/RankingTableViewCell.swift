//
//  RankingTableViewCell.swift
//  Kurly
//
//  Created by 김민 on 2022/11/30.
//

import UIKit

import SnapKit
import Then

// MARK: - RankingTableViewCell

class RankingTableViewCell: UITableViewCell {
    
    // MARK: - Identifier
    
    static let identifier = "RankingTableViewCell"
    
    // MARK: - UI Components
    
    private let rankingLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .kurlyPurple
    }
    
    private let productNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
    }

    // MARK: - Life Cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extension

extension RankingTableViewCell {
    
    // MARK: - Layout Helper
    
    private func layout() {
        
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
    
    private func config() {
        self.selectionStyle = .none
    }
    
    // MARK: - General Helper
    
    func dataBind(rankingModel: RankingModel) {
        rankingLabel.text = rankingModel.ranking
        productNameLabel.text = rankingModel.productNmae
    }
}
