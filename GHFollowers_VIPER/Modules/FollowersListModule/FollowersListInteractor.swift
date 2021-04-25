//
//  FollowersListInteractor.swift
//  GHFollowers_VIPER
//
//  Created by Ayman Ata on 4/24/21.
//  Copyright © 2021 Ayman Ata. All rights reserved.
//

import Foundation

class FollowersListInteractor {
    weak var presenter: FollowersListPresenterInterface?
    var userName: String!
    private let networkManger: NetworkManager = .init()
}

extension FollowersListInteractor: FollowersListInteractorInterface {
    func fetchFollowers(page: Int) {
        let endPoint = "/users/\(userName!)/followers?per_page=80&page=\(page)"
        networkManger.getObjects(ofType: [Follower].self,
                                 endpoint: endPoint, method: .get) { [weak self] (result) in
            print(result)
            switch result {
            case .success(let followers):
                self?.presenter?.followersFetched(followers: followers)
            case .failure(let err):
                self?.presenter?.followersFetchFailed(error: err.localizedDescription)
            }
        }
    }
    
    
}
