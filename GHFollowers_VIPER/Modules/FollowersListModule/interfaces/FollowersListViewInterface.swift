//
//  FollowersListViewInterface.swift
//  GHFollowers_VIPER
//
//  Created by Ayman Ata on 4/24/21.
//  Copyright © 2021 Ayman Ata. All rights reserved.
//

import Foundation
protocol FollowersListViewInterface: class {
    func setupUIElements()
    func showLoading()
    func hideLoading()
    func setScreen(title: String)
    func reloadData()
}
