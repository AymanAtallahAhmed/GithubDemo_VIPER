//
//  SearchPresenter.swift
//  GHFollowers_VIPER
//
//  Created by Ayman Ata on 4/24/21.
//  Copyright © 2021 Ayman Ata. All rights reserved.
//

import UIKit

class SearchPresenter {
    weak var view: SearchViewInterface?
    var router: SearchRouterInterface?
}

extension SearchPresenter: SearchPresenterInterface {
    func notifyViewWillDisappear() {
        view?.showNavigationBar()
    }
    
    func notifyViewWillAppear() {
        view?.hideNavigationBar()
    }
    
    func getFollowersFor(user: String) {
        router?.showFollowersList(for: user, on: view!)
    }
    
    func notifyViewDidLoad() {
        view?.setupUIElements()
    }
}
