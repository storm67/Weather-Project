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
import SideMenu

final class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate, SideMenuNavigationControllerDelegate {
    
    fileprivate var pageControl = UIPageControl()
    fileprivate var customPageControl = PageControl()
    fileprivate var pages = [UIViewController]()
    
    fileprivate var blurEffect: UIVisualEffectView! {
        didSet {
        self.blurEffect.layer.opacity = 0
        }
    }
    
    fileprivate var currentPage: Int {
        get {
            pageControl.currentPage
        }
    }
    
    fileprivate var citySelector: SideMenuNavigationController {
        get {
            let menu = storyboard?.instantiateViewController(withIdentifier: "PagesViewController") as! PagesViewController
            let nav = SideMenuNavigationController(rootViewController: menu)
            nav.presentationStyle = .menuSlideIn
            nav.menuWidth = 290
            nav.pushStyle = .popWhenPossible
            nav.modalPresentationStyle = .overCurrentContext
            return nav
        }
    }

    var manager: PageViewModelProtocol!
    
    let menu: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "slider"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(sideMenuAction), for: .touchUpInside)
        return button
    }()
    
    let searchIcon: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "search"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    func setupPageControl() {
        var count = 0
        if count == 0 {
        self.pageControl.numberOfPages = pages.count
        self.pageControl.currentPage = 0
        view.addSubview(customPageControl)
        customPageControl.translatesAutoresizingMaskIntoConstraints = false
        customPageControl.backgroundColor = .red
        customPageControl.pages = pages.count
        customPageControl.addCircle()
        NSLayoutConstraint.activate([
        customPageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        customPageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
        customPageControl.widthAnchor.constraint(equalToConstant: 60)
        ])
        }
        count += 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.isHidden = true
        layout()
        let blur = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        blurEffect = UIVisualEffectView(effect: blur)
        self.view.addSubview(blurEffect)
        self.dataSource = self
        delegate = self
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        toStart()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: .none)
    }
    
    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: .none)
    }
    
    func setUp() {
        manager.fetchData { [weak self] (md) in
            self?.pages = md
        }
    }
    
    func toStart() {
        pages = []
        setUp()
        setupPageControl()
        setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
        for subview in self.view.subviews {
            if let scrollView = subview as? UIScrollView {
                scrollView.delegate = self
                break;
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
        menu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -5).isActive = true
        menu.leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor, constant: 380).isActive = true
        menu.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        menu.widthAnchor.constraint(equalToConstant: 35).isActive = true
        menu.heightAnchor.constraint(equalToConstant: 35).isActive = true
        let widthConstraint = menu.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 10)
        widthConstraint.priority = UILayoutPriority(rawValue: 999)
        widthConstraint.isActive = true
    }
    
    @objc fileprivate func sideMenuAction() {
        guard let window = self.view.window, let root = window.rootViewController else { return }
        root.present(citySelector, animated: true, completion: nil)
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
        customPageControl.pagesCounter(offset: scrollView.contentOffset, width: scrollView.bounds.size.width)
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
    
    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        if manager.check() {
            DispatchQueue.global().sync {
            self.setUp()
            self.customPageControl.pages = self.pages.count
            self.setViewControllers([self.pages[0]], direction: .forward, animated: false, completion: nil)
            self.customPageControl.currentPage = 0
            self.customPageControl.addCircle()
            }
        }
    }
    
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        menu.enableSwipeToDismissGesture = false
        UIView.animate(withDuration: 0.4) {
                self.blurEffect.layer.opacity = 0
            }
    }
    
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        menu.enableSwipeToDismissGesture = false
        blurEffect.autoresizingMask = [.flexibleBottomMargin]
        blurEffect.frame = self.view.bounds
        UIView.animate(withDuration: 0.4) {
            self.blurEffect.layer.opacity = 0.3
        }
    }
}

