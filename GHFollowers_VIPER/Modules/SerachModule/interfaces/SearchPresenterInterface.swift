//
//  SearchPresenterInterface.swift
//  GHFollowers_VIPER
//
//  Created by Ayman Ata on 4/24/21.
//  Copyright © 2021 Ayman Ata. All rights reserved.
//

import UIKit

protocol SearchPresenterInterface: class {
    func notifyViewDidLoad()
    func notifyViewWillAppear()
    func notifyViewWillDisappear()
    func getFollowersFor(user: String)
}
