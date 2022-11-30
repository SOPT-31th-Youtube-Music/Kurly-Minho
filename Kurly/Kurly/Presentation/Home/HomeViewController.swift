//
//  ViewController.swift
//  Kurly
//
//  Created by 김민 on 2022/11/27.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
  private let segmentedControl: UISegmentedControl = {
    let segmentedControl = UnderlineSegmentedControl(items: ["컬리추천", "신상품", "베스트", "알뜰쇼핑", "특가/혜택"])
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    return segmentedControl
  }()
  private let headerView: UIView = {
    let view = UIView()
      view.backgroundColor = UIColor.purple
    return view
  }()

    private let iconImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "kurlyIcon")
        image.contentMode = .scaleAspectFit
        return image
    }()

//    let cv: UICollectionView = {
//
//            let layout = UICollectionViewFlowLayout()
//            layout.minimumLineSpacing = 10
//
//            layout.scrollDirection = .vertical
//            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//
//
//            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.backgroundColor = .systemPink
//
//            return cv
//        }()
    private let vc1: UIViewController = {
      let vc = UIViewController()
      vc.view.backgroundColor = .red
      return vc
    }()
  private let vc2: UIViewController = {
    let vc = UIViewController()
    vc.view.backgroundColor = .green
    return vc
  }()
  private let vc3: UIViewController = {
    let vc = UIViewController()
    vc.view.backgroundColor = .blue
    return vc
  }()
    private let vc4: UIViewController = {
      let vc = UIViewController()
      vc.view.backgroundColor = .systemPink
      return vc
    }()

    private let vc5: UIViewController = {
      let vc = UIViewController()
      vc.view.backgroundColor = .yellow
      return vc
    }()

  private lazy var pageViewController: UIPageViewController = {
    let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    vc.setViewControllers([self.dataViewControllers[0]], direction: .forward, animated: true)
    vc.delegate = self
    vc.dataSource = self
    vc.view.translatesAutoresizingMaskIntoConstraints = false
    return vc
  }()

  var dataViewControllers: [UIViewController] {
      [self.vc1, self.vc2, self.vc3, self.vc4, self.vc5]
  }
  var currentPage: Int = 0 {
    didSet {
      // from segmentedControl -> pageViewController 업데이트
      print(oldValue, self.currentPage)
      let direction: UIPageViewController.NavigationDirection = oldValue <= self.currentPage ? .forward : .reverse
      self.pageViewController.setViewControllers(
        [dataViewControllers[self.currentPage]],
        direction: direction,
        animated: true,
        completion: nil
      )
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

      [headerView, iconImage].forEach{
          view.addSubview($0)
      }

    self.view.addSubview(self.segmentedControl)
      self.view.addSubview(self.pageViewController.view)
      //vc1.view.addSubview(cv) collectionView 추가
      
      headerView.snp.makeConstraints{
          $0.top.leading.trailing.equalToSuperview()
          $0.height.equalTo(100)
      }

      iconImage.snp.makeConstraints{
          $0.top.equalToSuperview().offset(40)
          $0.leading.equalToSuperview().offset(15)
          $0.width.equalTo(74)
          $0.height.equalTo(60)
      }


    NSLayoutConstraint.activate([
      self.segmentedControl.leftAnchor.constraint(equalTo: self.view.leftAnchor),
      self.segmentedControl.rightAnchor.constraint(equalTo: self.view.rightAnchor),
      self.segmentedControl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
      self.segmentedControl.heightAnchor.constraint(equalToConstant: 50),
    ])
//    NSLayoutConstraint.activate([
//      self.pageViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
//      self.pageViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
//      self.pageViewController.view.bottomAnchor.constraint(equalTo: TabBarController, constant: 0),
//      self.pageViewController.view.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor, constant: 5),
//    ])
      pageViewController.view.snp.makeConstraints{
          $0.top.equalTo(segmentedControl.snp.bottom)
          $0.bottom.equalToSuperview().offset(-85)
          $0.leading.trailing.equalToSuperview()
      }

    self.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray,
                                                  .font: UIFont.systemFont(ofSize: 16, weight: .medium)], for: .normal)
    self.segmentedControl.setTitleTextAttributes(
      [
        NSAttributedString.Key.foregroundColor: UIColor.purple,
        .font: UIFont.systemFont(ofSize: 16, weight: .semibold)
      ],
      for: .selected
    )
    self.segmentedControl.addTarget(self, action: #selector(changeValue(control:)), for: .valueChanged)
    self.segmentedControl.selectedSegmentIndex = 0
    self.changeValue(control: self.segmentedControl)
  }

  @objc private func changeValue(control: UISegmentedControl) {
    // 코드로 값을 변경하면 해당 메소드 호출 x
    self.currentPage = control.selectedSegmentIndex
  }
}

extension HomeViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

  func pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerBefore viewController: UIViewController
  ) -> UIViewController? {
    guard
        let index = self.dataViewControllers.firstIndex(of: viewController ),
      index - 1 >= 0
    else { return nil }
    return self.dataViewControllers[index - 1]
  }
  func pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerAfter viewController: UIViewController
  ) -> UIViewController? {
    guard
      let index = self.dataViewControllers.firstIndex(of: viewController),
      index + 1 < self.dataViewControllers.count
    else { return nil }
    return self.dataViewControllers[index + 1]
  }
  func pageViewController(
    _ pageViewController: UIPageViewController,
    didFinishAnimating finished: Bool,
    previousViewControllers: [UIViewController],
    transitionCompleted completed: Bool
  ) {
    guard
      let viewController = pageViewController.viewControllers?[0],
      let index = self.dataViewControllers.firstIndex(of: viewController)
    else { return }
    self.currentPage = index
    self.segmentedControl.selectedSegmentIndex = index
  }
}


