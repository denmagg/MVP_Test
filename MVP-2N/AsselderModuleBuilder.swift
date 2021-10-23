//
//  ModuleBuilder.swift
//  MVP-2N
//
//  Created by Denis Medvedev on 05/10/2021.
//  Copyright © 2021 Denis Medvedev. All rights reserved.
//

import UIKit

protocol AsselderBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(comment: Comment?, router: RouterProtocol) -> UIViewController
}

//Внедрение зависимостей - те они создаются не внутри всех этих сущностей эти штуки, а снаружи и потом туда инжектятся
//Нужна по SOLID, и для того чтобы во время тестов подсунуть сюда мок объект, для того чтобы протестировать презентер.
class AsselderModuleBuilder: AsselderBuilderProtocol {
    
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let networkService = NetworkService()
        let view = MainViewController()
        let presenter = MainPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    func createDetailModule(comment: Comment?, router: RouterProtocol) -> UIViewController {
        let networkService = NetworkService()
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view, networkService: networkService, router: router, comment: comment)
        view.presenter = presenter
        return view
    }
    
}
