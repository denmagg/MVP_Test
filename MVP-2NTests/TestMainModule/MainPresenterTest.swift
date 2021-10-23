//
//  MainPresenterTest.swift
//  MVP-2NTests
//
//  Created by Denis Medvedev on 05/10/2021.
//  Copyright © 2021 Denis Medvedev. All rights reserved.
//

import XCTest
@testable import MVP_2N

class MockView: MainViewProtocol {
    func success() {
    }
    
    func failture(error: Error) {
    }
}

class MockNetworkService: NetworkServiceProtocol {
    var comments: [Comment]!
    
    init() {}
    
    convenience init(comments: [Comment]?) {
        self.init()
        self.comments = comments
    }
    
    func getComments(complition: @escaping (Result<[Comment]?, Error>) -> Void) {
        if let comments = comments {
            complition(.success(comments))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            complition(.failure(error))
        }
    }
    
}

class MainPresenterTest: XCTestCase {
    
    //создаем мок вью для того чтобы вью как-то отвечало и мы могли проверить что что-то как-то работает, чтобы тестировать бизнес логику нашего приложения
    //вью для того чтобы мы могли сверить снаружи как отработала бизнес логика
    var view: MockView!
//    var person: Person!
    var presenter: MainPresenter!
    var networkService: NetworkServiceProtocol!
    var router: RouterProtocol!
    var comments = [Comment]()

    //всегда когда будут вызываться тесты для каждого будет вызываться эта ф-я
    override func setUp() {
        let nav = UINavigationController()
        let assembly = AsselderModuleBuilder()
        router = Router(navigationController: nav, assembyBuilder: assembly)
    }

    //срабатывает каждый раз, когда заканчивается наш какой-то тест
    //каждое завершение теста принято нилить объекты, чтобы у нас не было никаких проблем
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        view = nil
        networkService = nil
        presenter = nil
    }

    //проверка пришел коммент или нет
    func testGetSuccesComments() {
        let comment = Comment(postId: 1, id: 2, name: "Foo", email: "Baz", body: "Bar")
        comments.append(comment)
        
        view = MockView()
        networkService = MockNetworkService(comments: [comment])
        presenter = MainPresenter(view: view, networkService: networkService, router: router)
        
        var catchComments: [Comment]?
        
        networkService.getComments { result in
            switch result {
            case .success(let comments):
                catchComments = comments
            case .failure(let error):
                print(error)
            }
        }
        
        XCTAssertNotEqual(catchComments?.count, 0)
        XCTAssertEqual(catchComments?.count, comments.count)
    }
    
    //проверка пришел коммент или нет
    func testGetFailureComments() {
        let comment = Comment(postId: 1, id: 2, name: "Foo", email: "Baz", body: "Bar")
        comments.append(comment)
        
        view = MockView()
        networkService = MockNetworkService()
        presenter = MainPresenter(view: view, networkService: networkService, router: router)
        
        var catchError: Error?
        
        networkService.getComments { result in
            switch result {
            case .success(let comments):
                print(comments)
            case .failure(let error):
                catchError = error
            }
        }
        
        XCTAssertNotNil(catchError)
    }
}
