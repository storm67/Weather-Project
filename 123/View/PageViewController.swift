//
//  PageViewController.swift
//  123
//
//  Created by gdml on 04/05/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    let menu: UIButton = {
        let label = UIButton()
        label.setImage(UIImage(named: "menu"), for: .normal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let searchIcon: UIButton = {
        let label = UIButton()
        label.setImage(UIImage(named: "search"), for: .normal)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.addTarget(self, action: #selector(buttonTapAction), for: .touchUpInside)
        return label
    }()
    
    let selected = Selected()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
    }
    
    var pageControl = UIPageControl()
    var pages = [UIViewController]()
    
    func setupPageControl() {
        self.view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 7).isActive = true
        self.pageControl.numberOfPages = pages.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.gray
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        pageControl.backgroundColor = UIColor.clear
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUp()
        setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
        self.dataSource = self
        self.delegate = self
        setupPageControl()
        layout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageControl.subviews.forEach {
            $0.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
    
    func setUp() {
        selected.fetchData { [weak self] (md) in
            for item in md {
                self?.pages.append(ViewController(model: SimpleModel(name: item.name, key: item.key, lat: item.lat, lon: item.lon)))
            }
        }
    }
    
    func layout() {
        view.addSubview(searchIcon)
        view.addSubview(menu)
        searchIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6).isActive = true
        searchIcon.topAnchor.constraint(equalTo: menu.topAnchor, constant: 3).isActive = true
        searchIcon.widthAnchor.constraint(equalToConstant: 28).isActive = true
        searchIcon.heightAnchor.constraint(equalToConstant: 28).isActive = true
        menu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        menu.leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor, constant: 380).isActive = true
        menu.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        menu.widthAnchor.constraint(equalToConstant: 31).isActive = true
        menu.heightAnchor.constraint(equalToConstant: 31).isActive = true
        let widthConstraint = menu.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 10)
        widthConstraint.priority = UILayoutPriority(rawValue: 999)
        widthConstraint.isActive = true
    }
    
    @objc fileprivate func buttonTapAction() {
        self.navigationController?.pushViewController(PagesViewController(), animated: true)
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
}

