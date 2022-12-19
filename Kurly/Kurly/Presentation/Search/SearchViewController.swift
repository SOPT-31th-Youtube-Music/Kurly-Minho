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
    
    enum Section: Int {
        case recent
        case recommend
        case ranking
    }
    
    enum SectionItem: Hashable {
        case recent(String)
        case recommend(String)
        case ranking(RankingModel)
    }
    
    // MARK: - Typealias
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, SectionItem>
    
    // MARK: - Variable
    
    var dataSource: DataSource! = nil
    
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
    
    // MARK: - Layout
    
    private func createCompositonalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionInt, layoutEnvironment) -> NSCollectionLayoutSection in
            switch sectionInt {
            case 0:
                return self.recentLayoutSection()
            case 1:
                return self.recommendLayoutSection()
            case 2:
                return self.rankingLayoutSection()
            default:
                return self.recentLayoutSection()
            }
        }
    }
    
    private func recentLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets =  NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(80),
                                               heightDimension: .absolute(35))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 15, trailing: 15)
        section.orthogonalScrollingBehavior = .continuous
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(30))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func recommendLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.15),
                                              heightDimension: .absolute(35))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(35))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 15, trailing: 15)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(30))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func rankingLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                           heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 15, trailing: 15)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(45))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        section.boundarySupplementaryItems = [header]
        
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
    
    // MARK: - General
    
    private func config() {
        searchTextField.setIcon(UIImage(systemName: "magnifyingglass")!)
        
        let recentCellRegisteration = UICollectionView.CellRegistration<RecentCollectionViewCell, SectionItem> { cell, indexPath, itemIdentifier in
            if case let SectionItem.recent(item) = itemIdentifier {
                cell.dataBind(productName: item)
            }
        }
        
        let recommendCellRegisteration = UICollectionView.CellRegistration<RecommendCollectionViewCell, SectionItem> { cell, indexPath, itemIdentifier in
            if case let SectionItem.recommend(item) = itemIdentifier {
                cell.dataBind(productName: item)
            }
        }
        
        let rankingCellRegisteration = UICollectionView.CellRegistration<RankingCollectionViewCell, SectionItem> { cell, indexPath, itemIdentifier in
            if case let SectionItem.ranking(item) = itemIdentifier {
                cell.dataBind(rankingModel: item)
            }
        }
        
        let firstHeaderRegistertaion = UICollectionView.SupplementaryRegistration<FirstHeaderView>(elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView, elementKind, indexPath in
            supplementaryView.dataBind(categoryName: categoryName[indexPath.section])
        }
        
        let rankingHeaderRegisteration = UICollectionView.SupplementaryRegistration<RankingHeaderView>(elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView, elementKind, indexPath in
        }
        
        dataSource = DataSource(collectionView: searchCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let section = Section(rawValue: indexPath.section)

            switch section {
            case .recent:
                return collectionView.dequeueConfiguredReusableCell(using: recentCellRegisteration, for: indexPath, item: itemIdentifier)
            case .recommend:
                return collectionView.dequeueConfiguredReusableCell(using: recommendCellRegisteration, for: indexPath, item: itemIdentifier)
            case .ranking:
                return collectionView.dequeueConfiguredReusableCell(using: rankingCellRegisteration, for: indexPath, item: itemIdentifier)
            default:
                return UICollectionViewCell()
            }
        })
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            switch index.section {
            case 2:
                return self.searchCollectionView.dequeueConfiguredReusableSupplementary(using: rankingHeaderRegisteration, for: index)
            default:
                return self.searchCollectionView.dequeueConfiguredReusableSupplementary(using: firstHeaderRegistertaion, for: index)
            }
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, SectionItem>()
        snapshot.appendSections([.recent, .recommend, .ranking])
        _ = recentData.map { snapshot.appendItems([.recent($0)], toSection: .recent) }
        _ = recommendData.map { snapshot.appendItems([.recommend($0)], toSection: .recommend) }
        _ = rankingData.map { snapshot.appendItems([.ranking($0)], toSection: .ranking) }
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
