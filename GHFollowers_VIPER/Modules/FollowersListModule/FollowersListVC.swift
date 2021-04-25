//
//  FollowersListVC.swift
//  GHFollowers_VIPER
//
//  Created by Ayman Ata on 4/24/21.
//  Copyright © 2021 Ayman Ata. All rights reserved.
//

import UIKit
import SVProgressHUD

class FollowersListVC: UIViewController {

    var presenter: FollowersListPresenterInterface?
    
    private var pageCounter = 1
    private var isSearching = false
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupSearcheController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search here for Followers"
        
        navigationItem.searchController = searchController
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.creat3ColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension FollowersListVC: FollowersListViewInterface {
    func reloadData() {
        collectionView.reloadData()
    }
    
    func showLoading() {
        SVProgressHUD.show()
    }
    
    func hideLoading() {
        SVProgressHUD.dismiss()
    }
    
    func setScreen(title: String) {
        navigationItem.title = title
    }
    
    func setupUIElements() {
        setupUI()
        setupCollectionView()
        setupSearcheController()
    }
}


extension FollowersListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text,
            filter != "" else { return }
        presenter?.searchFor(text: filter)
        isSearching = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.cancelSearch()
        isSearching = false
    }
}

extension FollowersListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getCurrentFollowers().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
        let follower = presenter?.getCurrentFollowers()[indexPath.item]
        cell.follower = follower
        return cell
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.height
        
        if offsetY > (contentHeight - screenHeight) {
            presenter?.fetchNextPage()
        }
    }
}
