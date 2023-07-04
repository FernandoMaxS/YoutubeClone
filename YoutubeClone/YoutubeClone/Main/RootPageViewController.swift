//
//  RootPageViewController.swift
//  YoutubeClone
//
//  Created by Fernando Maximiliano on 03/07/23.
//

import UIKit

protocol RootPageProtocol: AnyObject {
    func currentPage(_ index: Int)
}

class RootPageViewController: UIPageViewController {
    
    var subViewControllers = [UIViewController]()
    var currentIndex: Int = 0
    weak var delegateRoot: RootPageProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        setUpViewController()
    }
    
    private func setUpViewController(){
        subViewControllers = [
            HomeViewController(),
            VideosViewController(),
            PlaylistViewController(),
            ChannelViewController(),
            AboutViewController()
        ]
        _ = subViewControllers.enumerated().map({ $0.element.view.tag = $0.offset })
        setViewControllerFromIndex(index: 0, direction: .forward)
    }
    
//    override func setViewControllers(_ viewControllers: [UIViewController]?, direction: UIPageViewController.NavigationDirection, animated: Bool, completion: ((Bool) -> Void)? = nil) {
//        <#code#>
//    }
    func setViewControllerFromIndex(index: Int, direction: NavigationDirection, animated: Bool = true){
        setViewControllers([subViewControllers[index]], direction: direction, animated: animated)
        
    }
}

extension RootPageViewController: UIPageViewControllerDelegate{
    
}

extension RootPageViewController: UIPageViewControllerDataSource{
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index: Int = subViewControllers.firstIndex(of: viewController) ?? 0
        //Validamos porque a la izquierda no hay nada
        if index <= 0 {
            return nil
        }
        return subViewControllers[index-1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index: Int = subViewControllers.firstIndex(of: viewController) ?? 0
        //Validamos porque a la izquierda no hay nada
        if index >= subViewControllers.count-1 {
            return nil
        }
        return subViewControllers[index+1]
    
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        print("Finish: ",finished)
        
        if let index = pageViewController.viewControllers?.first?.view.tag{
            currentIndex = index
            delegateRoot?.currentPage(index)
        }
    }
    
    
}
