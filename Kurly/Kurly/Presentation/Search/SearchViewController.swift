//
//  SearchViewController.swift
//  Kurly
//
//  Created by 김민 on 2022/11/29.
//

import UIKit

import SnapKit
import Then

// MARK: - SearchViewController

class SearchViewController: UIViewController {
    
    // MARK: - UI Components
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()
    
    private let searchView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var searchTextField = UITextField().then {
        $0.backgroundColor = .systemGray6
        $0.placeholder = "검색어를 입력해 주세요"
        $0.layer.cornerRadius = 5
        $0.delegate = self
    }

    
    // MARK: - Life Cycles
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavigationBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        register()
        config()
    }
}

// MARK: - Extension

extension SearchViewController {
    
    // MARK: - Layout Helper
    
    private func layout() {
        
        view.backgroundColor = .kurlyPurple
        view.addSubviews(searchView,tableView)
        searchView.addSubview(searchTextField)
        
        searchView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        searchTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalToSuperview().offset(10)
            $0.centerX.centerY.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - General Helper
    
    private func config() {
        searchTextField.setIcon(UIImage(systemName: "magnifyingglass")!)
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backgroundColor = .kurlyPurple
        
        self.navigationItem.title = "검색"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium)
        ]
    }
    
    private func register() { 

        tableView.register(RecommendSearchTableViewCell.self, forCellReuseIdentifier: RecommendSearchTableViewCell.identifier)
        tableView.register(RiseSearchTableViewCell.self, forCellReuseIdentifier: RiseSearchTableViewCell.identifier)
    }
}

// MARK: - UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("탭하면 검색창으로 간다아아아아아아")
    }
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecommendSearchTableViewCell.identifier) as? RecommendSearchTableViewCell else {return UITableViewCell()}
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RiseSearchTableViewCell.identifier) as? RiseSearchTableViewCell else {return UITableViewCell()}
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SearchTableViewHeader()
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 150
        case 1:
            return 570
        default:
            return 0
        }
    }
}
