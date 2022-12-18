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
    
    // MARK: - Enum
    
    enum Section {
        case recent
    }
    
    // MARK: - Variable
    
    var dataSource: UICollectionViewDiffableDataSource<Section, String>! = nil
    
    // MARK: - UI Components
    
    private let searchView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var searchTextField = UITextField().then {
        $0.backgroundColor = .systemGray6
        $0.placeholder = "검색어를 입력해 주세요"
        $0.layer.cornerRadius = 5
        $0.delegate = self
    }
    
    private lazy var searchCollectionView: UICollectionView = {
        let layout = createCompositonalLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()

    
    // MARK: - Life Cycles
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavigationBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        config()
    }
}

// MARK: - Extension

extension SearchViewController {
    
    // MARK: - Layout Helper
    
    private func createCompositonalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionInt, layoutEnvironment) -> NSCollectionLayoutSection in
            switch sectionInt {
            case 0:
                return self.recentLayoutSection()
            default:
                return self.recentLayoutSection()
            }
        }
    }
    
    private func recentLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets =  NSDirectionalEdgeInsets(top: 0.0, leading: 5, bottom: 0.0, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(80),
                                               heightDimension: .absolute(35))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    private func setLayout() {
        
        view.backgroundColor = .kurlyPurple
        view.addSubviews(searchView, searchCollectionView)
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
        
        searchCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - General Helper
    
    private func config() {
        searchTextField.setIcon(UIImage(systemName: "magnifyingglass")!)
        
        let recentCellRegisteration = UICollectionView.CellRegistration<RecentCollectionViewCell, String> { cell, indexPath, itemIdentifier in
            cell.dataBind(productName: itemIdentifier)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, String> (collectionView: searchCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: recentCellRegisteration, for: indexPath, item: itemIdentifier)
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.recent])
        snapshot.appendItems(recentData)
        dataSource.apply(snapshot, animatingDifferences: false)
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
}

// MARK: - UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("탭하면 검색창으로 간다아아아아아아")
    }
}

// MARK: - UITableViewDataSource



// MARK: - UITableViewDelegate

//extension SearchViewController: UITableViewDelegate {
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        switch indexPath.row {
//        case 0:
//            return 150
//        case 1:
//            return 570
//        default:
//            return 0
//        }
//    }
//}
