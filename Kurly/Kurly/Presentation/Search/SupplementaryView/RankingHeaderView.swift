//
//  RankingHeaderView.swift
//  Kurly
//
//  Created by 김민 on 2022/12/19.
//

import UIKit

import SnapKit
import Then

// MARK: - RankingHeaderView

class RankingHeaderView: UICollectionReusableView {
    
    // MARK: - UI Component
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 17, weight: .semibold)
        $0.text = "급상승 검색어"
    }
    
    private let detailLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .lightGray
        $0.text = "최근 1시간 동안 검색 횟수가 급상승했어요"
    }
    
    private lazy var labelStackView = UIStackView(arrangedSubviews: [titleLabel, detailLabel]).then {
        $0.axis = .vertical
        $0.spacing = 5
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

extension RankingHeaderView {
    
    // MARK: - Layout
    
    private func setLayout() {
        self.addSubviews(labelStackView)
        
        labelStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
        }
    }
}
