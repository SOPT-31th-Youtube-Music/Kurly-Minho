//
//  RecommendSearchTableViewCell.swift
//  Kurly
//
//  Created by 김민 on 2022/11/29.
//

import UIKit

import SnapKit
import Then

// MARK: - RecommendSearchTableViewCell

class RecommendSearchTableViewCell: UITableViewCell {
    
    // MARK: - Constant
    
    final let recommendInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 10, right: 15)
    final let recommendItemSpacing: CGFloat = 3
    final let recommendLineSpacing: CGFloat = 7
    final let recommendCellHeight: CGFloat = 40

    // MARK: - Identifier
    
    static let identifier = "RecommendSearchTableViewCell"
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel().then { 
        $0.font = .systemFont(ofSize: 17, weight: .semibold)
        $0.text = "추천 검색어"
    }
    
    private lazy var recommendCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    // MARK: - Life Cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
        config()
        register()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extension

extension RecommendSearchTableViewCell {
    
    // MARK: - Layout Helper
    
    private func layout() {
        
        contentView.addSubviews(titleLabel, recommendCollectionView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(15)
        }
        
        recommendCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - General Helper
    
    private func register() {
        recommendCollectionView.register(RecommendCollectionViewCell.self, forCellWithReuseIdentifier: RecommendCollectionViewCell.identifier)
    }
    
    private func config() {
        self.selectionStyle = .none
    }
}

// MARK: - UICollectionViewDataSource

extension RecommendSearchTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.identifier, for: indexPath) as? RecommendCollectionViewCell else {return UICollectionViewCell()}

        cell.dataBind(productName: recommendData[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension RecommendSearchTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return recommendInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return recommendItemSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return recommendLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: recommendData[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).width + 20, height: recommendCellHeight)
    }
}
