//
//  FollowersListRouter.swift
//  GHFollowers_VIPER
//
//  Created by Ayman Ata on 4/24/21.
//  Copyright © 2021 Ayman Ata. All rights reserved.
//

import UIKit

class FollowersListRouter {
    weak var presenter: FollowersListPresenterInterface?
    
    static func creatModule(for user: String) -> FollowersListVC {
        // creating layers
        let router: FollowersListRouter = .init()
        let presenter: FollowersListPresenter = .init()
        let interactor: FollowersListInteractor = .init()
        let view: FollowersListVC = .init()
        
        // connecting layers
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        presenter.userName = user
        view.presenter = presenter
        
        interactor.presenter = presenter
        interactor.userName = user
        router.presenter = presenter
        
        return view
    }
}

extension FollowersListRouter: FollowersListRouterInterface {
    func presnetAlert(message: String) {
        let alertController = UIAlertController.init(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        guard let currentVC = UIApplication.shared.windows.first?.rootViewController else { return }
        //self.navigationController?.visibleViewController?
        currentVC.present(alertController, animated: true, completion: nil)
    }
    
    
}
