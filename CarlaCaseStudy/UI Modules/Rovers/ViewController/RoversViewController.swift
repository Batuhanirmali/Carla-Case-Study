//
//  ViewController.swift
//  CarlaCaseStudy
//
//  Created by Talha Batuhan Irmalı on 5.06.2024.
//

import UIKit

class RoversViewController: UIViewController {
    
    private let viewModel = RoversViewModel()
    private let loadingIndicator = UIActivityIndicatorView(style: .medium)

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topChooseLabel: UILabel!
    @IBOutlet weak var topChooseView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChooseLabel()
        setupTableView()
        setupLoadingIndicator()
        bindViewModel()
        startLoading()
        viewModel.fetchRovers()
    }
    
    func setupChooseLabel() {
        topChooseLabel.setInterFont(.regular, size: 14)
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "RoversTableViewCell", bundle: nil), forCellReuseIdentifier: "RoversTableViewCell")
        tableView.tableHeaderView = topChooseView
    }
    
    func setupLoadingIndicator() {
        loadingIndicator.center = view.center
        loadingIndicator.hidesWhenStopped = true
        view.addSubview(loadingIndicator)
    }
    
    func bindViewModel() {
        viewModel.onRoversFetched = { [weak self] in
            DispatchQueue.main.async {
                self?.stopLoading()
                self?.tableView.reloadData()
            }
        }
        
        viewModel.onError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.stopLoading()
                print(errorMessage)
            }
        }
    }
    
    func startLoading() {
        loadingIndicator.startAnimating()
        tableView.isHidden = true
    }
    
    func stopLoading() {
        loadingIndicator.stopAnimating()
        tableView.isHidden = false
    }
}

extension RoversViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.rovers.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RoversTableViewCell", for: indexPath) as? RoversTableViewCell else {
            return UITableViewCell()
        }
        
        let rover = viewModel.rovers[indexPath.section]
        let photoUrl = viewModel.latestPhotoUrls[rover.name]
        cell.configure(with: rover, photoUrl: photoUrl)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedRover = viewModel.rovers[indexPath.section]
        navigateToRoverDetail(roverName: selectedRover.name)
    }
    
    private func navigateToRoverDetail(roverName: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "RoversDetailViewController") as? RoversDetailViewController {
            let viewModel = RoversDetailViewModel(roverName: roverName)
            detailVC.viewModel = viewModel
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
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

