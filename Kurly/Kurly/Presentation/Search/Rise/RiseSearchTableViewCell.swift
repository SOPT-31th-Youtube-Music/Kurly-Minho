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
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 17, weight: .semibold)
        $0.text = "급상승 검색어"
    }
    
    private let detailLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.text = "최근 1시간 동안 검색 횟수가 급상승했어요"
        $0.textColor = .lightGray
    }
    
    private lazy var riseTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .yellow
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        tableView.separatorColor = .black.withAlphaComponent(0.1)
        
        tableView.delegate = self
        tableView.dataSource = self

        
        return tableView
    }()
    
    // MARK: - Life Cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
        register()
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extension

extension RiseSearchTableViewCell {
    
    // MARK: - Layout Helper
    
    private func layout() {
        
        contentView.addSubviews(titleLabel, detailLabel, riseTableView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(15)
        }
        
        detailLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(7)
            $0.leading.equalTo(titleLabel)
        }
        
        riseTableView.snp.makeConstraints {
            $0.top.equalTo(detailLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50*rankingData.count)
        }
    }
    
    // MARK: - General Helper
    
    private func register() {
        riseTableView.register(RankingTableViewCell.self, forCellReuseIdentifier: RankingTableViewCell.identifier)
    }
    
    private func config() {
        self.selectionStyle = .none
    }
}

// MARK: - UITableViewDataSource

extension RiseSearchTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankingData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RankingTableViewCell.identifier, for: indexPath) as? RankingTableViewCell else {return UITableViewCell()}
        
        cell.dataBind(rankingModel: rankingData[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension RiseSearchTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
