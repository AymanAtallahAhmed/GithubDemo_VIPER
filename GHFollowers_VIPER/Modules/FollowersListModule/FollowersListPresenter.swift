//
//  FollowersListPresenter.swift
//  GHFollowers_VIPER
//
//  Created by Ayman Ata on 4/24/21.
//  Copyright © 2021 Ayman Ata. All rights reserved.
//

import Foundation

class FollowersListPresenter {
    weak var view: FollowersListViewInterface?
    var router: FollowersListRouterInterface?
    var interactor: FollowersListInteractorInterface?
    
    var userName: String?
    private var allFollowers: [Follower] = []
    private var currentFollowers: [Follower] = []
    private var page: Int = 1
}

extension FollowersListPresenter: FollowersListPresenterInterface {
    func searchFor(text: String) {
        currentFollowers = allFollowers
            .filter({ $0.login.lowercased().contains(text.lowercased()) })
        view?.reloadData()
    }
    
    func cancelSearch() {
        currentFollowers = allFollowers
        view?.reloadData()
    }
    
    func getCurrentFollowers() -> [Follower] {
        return self.currentFollowers
    }
    
    func fetchNextPage() {
        page += 1
        view?.showLoading()
        interactor?.fetchFollowers(page: page)
    }
    
    func followersFetched(followers: [Follower]) {
        self.allFollowers.append(contentsOf: followers)
        currentFollowers = allFollowers
        view?.reloadData()
        view?.hideLoading()
    }
    
    func followersFetchFailed(error: String) {
        router?.presnetAlert(message: error)
        view?.hideLoading()
    }
    
    func notifyViewDidLoad() {
        view?.setupUIElements()
        view?.setScreen(title: self.userName ?? "")
        interactor?.fetchFollowers(page: page)
        view?.showLoading()
    }
    
}
