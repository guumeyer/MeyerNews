//
//  MenuViewControllerDelegate.swift
//  NewDesigner
//
//  Created by gustavo r meyer on 1/19/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import Foundation

protocol MenuViewControllerDelegate: class {
    func menuViewControllerDidTouchTop(_ controller: MenuViewController)
    func menuViewControllerDidTouchRecent(_ controller: MenuViewController)
    func menuViewControllerDidTouchLogout(_ controller: MenuViewController)
}
