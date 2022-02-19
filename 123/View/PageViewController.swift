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

final class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate, OpenSelectorManager, NavigationBackDetector {
    
    var isMoveToParent = false
    var pages = [UIViewController]()
    var viewModel: PageViewModelProtocol!
    
    fileprivate var pageControl = UIPageControl()
    fileprivate var customPageControl: PageControl!
    fileprivate var count = 0
    
    fileprivate var blurEffect: UIVisualEffectView = {
        let blur = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        let effect = UIVisualEffectView(effect: blur)
        effect.layer.opacity = 0
        return effect
    }()

    fileprivate var currentPage: Int {
        get {
            pageControl.currentPage
        }
    }
    
    fileprivate var sideMenuController: SideMenuNavigationController {
        get {
            let menu = storyboard?.instantiateViewController(withIdentifier: .pagesViewController) as! PagesViewController
            menu.manager = self
            let nav = SideMenuNavigationController(rootViewController: menu)
            nav.presentationStyle = .menuSlideIn
            nav.menuWidth = 290
            nav.pushStyle = .popWhenPossible
            nav.modalPresentationStyle = .overCurrentContext
            return nav
        }
    }
    
    fileprivate let menu: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "slider"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(sideMenuAction), for: .touchUpInside)
        return button
    }()
    
    fileprivate let searchIcon: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "search"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    fileprivate func setupPageControl() {
        if count == 0 {
        self.pageControl.numberOfPages = pages.count
        self.pageControl.currentPage = 0
        customPageControl = PageControl(circle: Circle(frame: .zero, strokeColor: .clear, fillColor: .black))
        view.addSubview(customPageControl)
        customPageControl.translatesAutoresizingMaskIntoConstraints = false
        customPageControl.backgroundColor = .red
        customPageControl.pages = pages.count
        customPageControl.addCircle(viewModel.extractor())
        NSLayoutConstraint.activate([
        customPageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        customPageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
        ])
        }
        count += 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(notifyHandler(notification:)), name: .notify, object: nil)
        view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.isTranslucent = false
        layout()
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
    
    fileprivate func setUp() {
        viewModel.fetchData { [weak self] (md) in
            self?.pages = md
        }
    }
    
    func toStart() {
        pages = []
        setUp()
        setupPageControl()
        self.customPageControl.currentPage = 0
        self.customPageControl.setNeedsDisplay()
        self.pageControl.currentPage = 0
        setViewControllers([pages[currentPage]], direction: .forward, animated: true, completion: nil)
        for views in self.pages {
        views.loadViewIfNeeded()
        }
        for subview in self.view.subviews {
            if let scrollView = subview as? UIScrollView {
                scrollView.delegate = self
                break;
            }
        }
        self.customPageControl.checkColor(bool: viewModel.extractor())
    }
    
    fileprivate func layout() {
        view.backgroundColor = .white
        view.addSubview(menu)
        view.addSubview(blurEffect)
        NSLayoutConstraint.activate([
        menu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -5),
        menu.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 385),
        menu.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
        menu.heightAnchor.constraint(equalToConstant: 35),
        ])
        let constraint = menu.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 10)
        constraint.priority = UILayoutPriority(999)
        constraint.isActive = true
    }
    
    func open() {
        let vc = storyboard?.instantiateViewController(identifier: .citySelector) as! CitySelector
        vc.isHide = false
        navigationController?.pushViewController(vc, animated: true)
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
    
}

extension PageViewController: SideMenuNavigationControllerDelegate {
    
    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        if viewModel.check() {
            DispatchQueue.global().sync {
            self.setUp()
            if viewModel.extractor() {
            self.customPageControl.pages = self.pages.count
            }
            self.toStart()
            self.customPageControl.currentPage = 0
            self.customPageControl.addCircle(viewModel.extractor())
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
