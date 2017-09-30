//
//  OnboardingViewController.swift
//  mapify
//
//  Created by Caleb Davis on 9/30/17.
//  Copyright © 2017 Caleb Davis. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    // Cell Identifiers
    fileprivate let cellId = "cellId"
    fileprivate let loginCellId = "loginCellId"

    fileprivate let pages: [Page] = {

        let firstPage = Page(title: "Go on adventures", message: "Explore the world and find life changing experiences for free.", imageName: "kayak")

        let secondPage = Page(title: "Share your maps", message: "Tap the share button to share your custom map with Facebook.", imageName: "beautiful")

        let thirdPage = Page(title: "Find maps by other people", message: "Download a map from other users to find new things to do, places to eat, or anything that interests you.", imageName: "mountains")

        return [firstPage, secondPage, thirdPage]
    }()

    // UIElements

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.register(PageCell.self, forCellWithReuseIdentifier: cellId)
        cv.register(LoginCell.self, forCellWithReuseIdentifier: loginCellId)
        return cv
    }()

    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1)
        pc.numberOfPages = self.pages.count + 1
        return pc
    }()

    lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(skip), for: .touchUpInside)
        return button
    }()

    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        return button
    }()

    override func loadView() {
        super.loadView()

        /// Add Subviews
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        view.addSubview(nextButton)

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)

        /// Constraints
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(40)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
        }

        skipButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(16)
            make.width.equalTo(60)
            make.height.equalTo(50)
        }

        nextButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-16)
            make.width.equalTo(60)
            make.height.equalTo(50)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    fileprivate func moveButtonsAndControlConstraints(bottomValue: Int, topValue: Int){
        pageControl.snp.updateConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(bottomValue)
        }

        skipButton.snp.updateConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(topValue)
        }

        nextButton.snp.updateConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(topValue)
        }
    }

    @objc func nextPage() {

        // on the last page
        if pageControl.currentPage == pages.count{
            return
        }
        // second last page
        if pageControl.currentPage == pages.count - 1 {
            moveButtonsAndControlConstraints(bottomValue: 40, topValue: -80)
        }

        let indexPath = IndexPath(item: pageControl.currentPage + 1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage += 1
    }

    @objc func skip() {
        pageControl.currentPage = pages.count - 1
        nextPage()
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = pageNumber

        // we are on the last page
        if pageNumber == pages.count {
            moveButtonsAndControlConstraints(bottomValue: 40, topValue: -80)
        } else {
            moveButtonsAndControlConstraints(bottomValue: 0, topValue: 10)
        }

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)

    }

}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.item == pages.count {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath) as! LoginCell
            return loginCell
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCell

        let page = pages[indexPath.item]
        cell.page = page
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        //print(UIDevice.current.orientation.isLandscape)
        collectionView.collectionViewLayout.invalidateLayout()

        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)

        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }

    }
}
