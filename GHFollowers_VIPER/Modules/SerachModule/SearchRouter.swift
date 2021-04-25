//
//  SearchRouter.swift
//  GHFollowers_VIPER
//
//  Created by Ayman Ata on 4/24/21.
//  Copyright © 2021 Ayman Ata. All rights reserved.
//

import UIKit

class SearchRouter {
    weak var presenter: SearchPresenterInterface?
    //var navigationController: UINavigationController?
    
    static func createModule() -> UINavigationController {
        // layers
        let router: SearchRouter = .init()
        let presenter: SearchPresenter = .init()
        let view: SearchVC = .init()
        
        // connect layers
        presenter.router = router
        presenter.view = view
        view.presenter = presenter
        router.presenter = presenter
        //router.navigationController = navigationController
        return UINavigationController.init(rootViewController: view)
    }
}

extension SearchRouter: SearchRouterInterface {
    func showFollowersList(for userName: String, on view: SearchViewInterface) {
        let vc = view as! SearchVC
        let followersVC = FollowersListRouter
            .creatModule(for: userName)
        vc.navigationController?.pushViewController(followersVC, animated: true)
    }
}
