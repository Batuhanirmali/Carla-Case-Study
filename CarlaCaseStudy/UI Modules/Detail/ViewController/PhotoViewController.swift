//
//  PhotoViewController.swift
//  CarlaCaseStudy
//
//  Created by Talha Batuhan Irmalı on 6.06.2024.
//

import UIKit
import SDWebImage

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var viewModel = PhotoViewModel()
    var index: Int = 0
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingIndicator()
        loadPhoto()
        setupTapGesture()
    }
    
    private func setupLoadingIndicator() {
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func loadPhoto() {
        loadingIndicator.startAnimating()
        viewModel.loadPhoto { [weak self] image in
            self?.loadingIndicator.stopAnimating()
            self?.imageView.image = image
        }
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
    }
    
    @objc private func imageTapped() {
        guard let photo = viewModel.photo else { return }
        let fullScreenVC = FullScreenImageViewController()
        fullScreenVC.viewModel.photo = photo
        fullScreenVC.modalPresentationStyle = .pageSheet
        present(fullScreenVC, animated: true, completion: nil)
    }
}


