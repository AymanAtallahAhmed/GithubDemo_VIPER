//
//  FollowersListPresenterInterface.swift
//  GHFollowers_VIPER
//
//  Created by Ayman Ata on 4/24/21.
//  Copyright © 2021 Ayman Ata. All rights reserved.
//

import Foundation

protocol FollowersListPresenterInterface: class {
    // view --> presenter
    func notifyViewDidLoad()
    func fetchNextPage()
    func getCurrentFollowers() -> [Follower]
    func searchFor(text: String)
    func cancelSearch()
    
    // interactor --> presenter
    func followersFetched(followers: [Follower])
    func followersFetchFailed(error: String)
}
