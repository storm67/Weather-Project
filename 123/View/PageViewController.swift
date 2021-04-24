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
    fileprivate var customPageControl: PageControl!
    fileprivate var pages = [UIViewController]()
    
    fileprivate var blurEffect: UIVisualEffectView! {
        didSet {
        self.blurEffect.layer.opacity = 0
        }
    }
    fileprivate var count = 0
    fileprivate var currentPage: Int {
        get {
            pageControl.currentPage
        }
    }
    
    fileprivate var sideMenuController: SideMenuNavigationController {
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
        if count == 0 {
        self.pageControl.numberOfPages = pages.count
        self.pageControl.currentPage = 0
        customPageControl = PageControl(circle: Circle(frame: .zero, strokeColor: .clear, fillColor: .lightGray))
        view.addSubview(customPageControl)
        customPageControl.translatesAutoresizingMaskIntoConstraints = false
        customPageControl.backgroundColor = .red
        customPageControl.pages = pages.count
        customPageControl.addCircle(manager.extractor())
        NSLayoutConstraint.activate([
        customPageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        customPageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
        ])
        }
        count += 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(notifyHandler(notification:)), name: Notification.Name.notify, object: nil)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
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
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: .none)
    }
    
    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: .none)
    }
       
    @objc func notifyHandler(notification: Notification) {
        guard let controller = sideMenuController.topViewController as? PagesViewController else { return }
        controller.addPrimitiveData(notification: notification)
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
        if self.manager.extractor() {
        setViewControllers([pages[1]], direction: .forward, animated: true, completion: { _ in
        self.pageControl.currentPage = 1
        self.customPageControl.currentPage = 1
        self.customPageControl.setNeedsDisplay()
        })} else {
        setViewControllers([pages[currentPage]], direction: .forward, animated: true, completion: { _ in
        self.pageControl.currentPage = 0
        self.customPageControl.currentPage = 0
        self.customPageControl.setNeedsDisplay()
        })}
//        for views in self.pages {
//        views.loadViewIfNeeded()
//        }
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
        NSLayoutConstraint.activate([
        searchIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6),
        searchIcon.topAnchor.constraint(equalTo: menu.topAnchor, constant: 3),
        searchIcon.widthAnchor.constraint(equalToConstant: 28),
        searchIcon.heightAnchor.constraint(equalToConstant: 28),
        menu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -5),
        menu.leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor, constant: 380),
        menu.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        menu.widthAnchor.constraint(equalToConstant: 35),
        menu.heightAnchor.constraint(equalToConstant: 35),
        ])
        let constraint = menu.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 10)
        constraint.priority = UILayoutPriority(999)
        constraint.isActive = true
    }
    
    @objc fileprivate func sideMenuAction() {
        guard let window = self.view.window, let root = window.rootViewController else { return }
        root.present(sideMenuController, animated: true, completion: nil)
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
                if viewControllerIndex == 0 {
                let nav = ClearNavigationController()
                let trans = TransitionController()
                nav.transitioningDelegate = trans
                nav.modalPresentationStyle = .custom
                present(nav, animated: true)
                }
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
            if manager.extractor() {
            self.customPageControl.pages = self.pages.count
            }
            self.toStart()
            self.customPageControl.currentPage = 0
            self.customPageControl.addCircle(manager.extractor())
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

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

