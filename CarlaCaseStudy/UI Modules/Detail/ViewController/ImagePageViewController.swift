//
//  ImagePageViewController.swift
//  CarlaCaseStudy
//
//  Created by Talha Batuhan Irmalı on 6.06.2024.
//

import UIKit

class ImagePageViewController: UIPageViewController {
    
    var viewModel = ImagePageViewModel()
    private var pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        if let firstVC = photoViewController(for: 0) {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        setupPageControl()
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = viewModel.photos.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = UIColor(hex: "#FFD159")
        pageControl.pageIndicatorTintColor = UIColor(hex: "#DFDFE7")
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func photoViewController(for index: Int) -> PhotoViewController? {
        guard index >= 0, index < viewModel.photos.count else { return nil }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let photoVC = storyboard.instantiateViewController(withIdentifier: "PhotoViewController") as? PhotoViewController {
            let photoViewModel = PhotoViewModel()
            photoViewModel.photo = viewModel.photos[index]
            photoVC.viewModel = photoViewModel
            photoVC.index = index
            return photoVC
        }
        return nil
    }
}

extension ImagePageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let photoVC = viewController as? PhotoViewController else { return nil }
        let index = photoVC.index
        return photoViewController(for: index - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let photoVC = viewController as? PhotoViewController else { return nil }
        let index = photoVC.index
        return photoViewController(for: index + 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let visibleVC = viewControllers?.first as? PhotoViewController {
                pageControl.currentPage = visibleVC.index
            }
        }
    }
}
