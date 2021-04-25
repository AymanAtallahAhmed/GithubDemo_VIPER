//
//  SearchRouterInterface.swift
//  GHFollowers_VIPER
//
//  Created by Ayman Ata on 4/24/21.
//  Copyright © 2021 Ayman Ata. All rights reserved.
//

import UIKit

protocol SearchRouterInterface: class {
    func showFollowersList(for userName: String, on view: SearchViewInterface)
}
