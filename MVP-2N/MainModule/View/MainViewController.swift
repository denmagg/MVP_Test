//
//  ViewController.swift
//  MVP-2N
//
//  Created by Denis Medvedev on 05/10/2021.
//  Copyright © 2021 Denis Medvedev. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: @IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MainViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let comment = presenter.comments?[indexPath.row]
        cell.textLabel?.text = comment?.body
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comment = presenter.comments?[indexPath.row]
        presenter.tapOnTheComment(comment: comment)
        //let detailViewController = AsselderModuleBuilder.createDetailModule(comment: comment)
        //navigationController?.pushViewController(detailViewController, animated: true)
    }
}

//экстеншн - биндинг.
//Когда нам презентер пришлет что-то там засетить, то мы просто передаем значение в лейбл
//это такой некий делегат получается. Биндинг вот в таком роде.
extension MainViewController: MainViewProtocol {
    func success() {
        tableView.reloadData()
    }
    
    func failture(error: Error) {
        print(error.localizedDescription)
    }

}

