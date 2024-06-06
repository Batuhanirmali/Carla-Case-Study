//
//  RoversDetailViewController.swift
//  CarlaCaseStudy
//
//  Created by Talha Batuhan Irmalı on 5.06.2024.
//

import UIKit

class RoversDetailViewController: UIViewController {
    
    var viewModel: RoversDetailViewModel!

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var numberOfCamerasLabel: UILabel!
    @IBOutlet weak var numberOfPhotosLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeaderView: UIView!
    
    private let loadingIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupLoadingIndicator()
        setupTableView()
        bindViewModel()
        viewModel.fetchLatestPhotos()
    }
    
    private func setupLoadingIndicator() {
        loadingIndicator.center = view.center
        loadingIndicator.hidesWhenStopped = true
        view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoTableViewCell")
        tableView.tableHeaderView = tableHeaderView
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.isHidden = true
    }
    
    private func setupNavigationBar() {
        self.title = viewModel.roverName
        let backButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func bindViewModel() {
        viewModel.updateRoverDetails = { [weak self] in
            DispatchQueue.main.async {
                self?.numberOfCamerasLabel.text = "Number of Cameras: \(self?.viewModel.numberOfCameras() ?? 0)"
                self?.numberOfPhotosLabel.text = "Number of Photos: \(self?.viewModel.numberOfPhotos() ?? 0)"
                self?.setupPageViewController()
                self?.tableView.reloadData()
                self?.loadingIndicator.stopAnimating()
                self?.tableView.isHidden = false
            }
        }
        
        viewModel.onError = { [weak self] error in
            DispatchQueue.main.async {
                self?.loadingIndicator.stopAnimating()
                // Show error message
                print(error)
            }
        }
    }
    
    private func setupPageViewController() {
        guard let pageVC = storyboard?.instantiateViewController(withIdentifier: "ImagePageViewController") as? ImagePageViewController else { return }
        let lastThreePhotos = Array(viewModel.photos.suffix(3))
        pageVC.viewModel.photos = lastThreePhotos
        addChild(pageVC)
        containerView.addSubview(pageVC.view)
        pageVC.view.frame = containerView.bounds
        pageVC.didMove(toParent: self)
    }
    
    private func showFullScreenImage(for photo: Photo) {
        let fullScreenVC = FullScreenImageViewController()
        fullScreenVC.viewModel.photo = photo
        fullScreenVC.modalPresentationStyle = .pageSheet
        present(fullScreenVC, animated: true, completion: nil)
    }
}

extension RoversDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.photos.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as? PhotoTableViewCell else {
            return UITableViewCell()
        }
        
        let photo = viewModel.photos[indexPath.section]
        cell.configure(with: photo)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedPhoto = viewModel.photos[indexPath.section]
        showFullScreenImage(for: selectedPhoto)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 18
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
}


