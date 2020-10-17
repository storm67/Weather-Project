//
//  PageViewController.swift
//  123
//
//  Created by gdml on 04/05/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import UIKit
import Swinject

final class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate {
    
    var currentPage: Int {
        get {
            pageControl.currentPage
        }
    }
    
    let menu: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "menu"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let searchIcon: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "search"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapAction), for: .touchUpInside)
        return button
    }()
    
    var manager: PageViewModelProtocol!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    var pageControl = UIPageControl()
    var pages = [UIViewController]()
    
    func setupPageControl() {
        self.view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
        self.pageControl.numberOfPages = pages.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.gray
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.backgroundColor = UIColor.clear
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        pages = []
        setUp()
        setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
        self.dataSource = self
        self.delegate = self
        setupPageControl()
        layout()
        for subview in self.view.subviews {
            if let scrollView = subview as? UIScrollView {
                scrollView.delegate = self
                break;
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageControl.subviews.forEach {
            $0.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
    
    func setUp() {
        manager.fetchData { [weak self] (md) in
            self?.pages = md
        }
    }
    
    func layout() {
        view.addSubview(searchIcon)
        view.addSubview(menu)
        searchIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6).isActive = true
        searchIcon.topAnchor.constraint(equalTo: menu.topAnchor, constant: 3).isActive = true
        searchIcon.widthAnchor.constraint(equalToConstant: 28).isActive = true
        searchIcon.heightAnchor.constraint(equalToConstant: 28).isActive = true
        menu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        menu.leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor, constant: 380).isActive = true
        menu.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        menu.widthAnchor.constraint(equalToConstant: 31).isActive = true
        menu.heightAnchor.constraint(equalToConstant: 31).isActive = true
        let widthConstraint = menu.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 10)
        widthConstraint.priority = UILayoutPriority(rawValue: 999)
        widthConstraint.isActive = true
    }
    
    @objc fileprivate func buttonTapAction() {
        let vc = storyboard?.instantiateViewController(identifier: "PagesViewController") as! PagesViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex != 0 {
                return self.pages[viewControllerIndex - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
                return self.pages[viewControllerIndex + 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.pages.firstIndex(of: viewControllers[0]) {
                self.pageControl.currentPage = viewControllerIndex
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (currentPage == 0 && scrollView.contentOffset.x < scrollView.bounds.size.width) {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0);
        } else if (currentPage == pages.count - 1 && scrollView.contentOffset.x > scrollView.bounds.size.width) {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0);
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if (currentPage == 0 && scrollView.contentOffset.x <= scrollView.bounds.size.width) {
            targetContentOffset.pointee = CGPoint(x: scrollView.bounds.size.width, y: 0);
        } else if (currentPage == pages.count - 1 && scrollView.contentOffset.x >= scrollView.bounds.size.width) {
            targetContentOffset.pointee = CGPoint(x: scrollView.bounds.size.width, y: 0);
        }
    }
}
