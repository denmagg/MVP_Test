//
//  DetailViewController.swift
//  MVP-2N
//
//  Created by Denis Medvedev on 06/10/2021.
//  Copyright © 2021 Denis Medvedev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var commentLabel: UILabel!
    
    var presenter: DetailViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setComment()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapAction(_ sender: Any) {
        presenter.tap()
    }
}

extension DetailViewController: DetailViewProtocol {
    func setComment(comment: Comment?) {
        commentLabel.text = comment?.body
    }
}
