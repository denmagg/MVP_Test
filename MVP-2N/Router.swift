//
//  RouterProtocol.swift
//  MVP-2N
//
//  Created by Denis Medvedev on 06/10/2021.
//  Copyright © 2021 Denis Medvedev. All rights reserved.
//

import UIKit

//базовый тип для всех роутеров
protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assembyBuilder: AsselderBuilderProtocol? { get set }
}

//для конкретного роутера
protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetail(comment: Comment?)
    func popToRoot()
}

class Router : RouterProtocol {
    var navigationController: UINavigationController?
    
    var assembyBuilder: AsselderBuilderProtocol?
    
    init(navigationController: UINavigationController?, assembyBuilder: AsselderBuilderProtocol?){
        self.navigationController = navigationController
        self.assembyBuilder = assembyBuilder
    }

    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assembyBuilder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showDetail(comment: Comment?) {
        if let navigationController = navigationController {
            guard let detailViewController = assembyBuilder?.createDetailModule(comment: comment, router: self) else { return }
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
