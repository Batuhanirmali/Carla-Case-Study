//
//  FullScreenImageViewController.swift
//  CarlaCaseStudy
//
//  Created by Talha Batuhan Irmalı on 6.06.2024.
//

import UIKit
import SDWebImage

class FullScreenImageViewController: UIViewController {
    
    var viewModel = FullScreenImageViewModel()
    private let imageView = UIImageView()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupImageView()
        setupLoadingIndicator()
        loadPhoto()
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreen))
        view.addGestureRecognizer(tapGesture)
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
    
    @objc private func dismissFullscreen() {
        dismiss(animated: true, completion: nil)
    }
}


