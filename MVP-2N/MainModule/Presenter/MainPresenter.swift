//
//  MainPresenter.swift
//  MVP-2N
//
//  Created by Denis Medvedev on 05/10/2021.
//  Copyright © 2021 Denis Medvedev. All rights reserved.
//

import Foundation

//протокол для вьюхи
protocol MainViewProtocol: class {
    //метод который будет отправлять сообщения нашей вьюхе
    func success()
    func failture(error: Error)
}

//протокол для входа данных
protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func getComments()
    var comments: [Comment]? { get set }
    func tapOnTheComment(comment: Comment?)
}

class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    var comments: [Comment]?
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getComments()
    }
    
    func tapOnTheComment(comment: Comment?) {
        router?.showDetail(comment: comment)
    }
    
    func getComments() {
        networkService.getComments { [weak self] result in
            guard let self = self else { return }
            //вызываем, потому что если мы сделаем success и во view  начнем релоудить таблицу, то у нас все брякнется
            //потому что возвращается все через URLSession асинхронно и соответственно success полетит во VC тоже асинхронно
            //и тк у нас UI не работает в main потоке у нас все брякнестя
            DispatchQueue.main.async {
                switch result {
                    //если пришел success, то сюда вернутся комменты через ассоциаливный тип
                case .success(let comments):
                    self.comments = comments
                    self.view?.success()
                case .failure(let error):
                    self.view?.failture(error: error)
                }
            }
        }
    }
    
    
}

