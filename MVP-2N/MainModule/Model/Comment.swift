//
//  Person.swift
//  MVP-2N
//
//  Created by Denis Medvedev on 05/10/2021.
//  Copyright © 2021 Denis Medvedev. All rights reserved.
//

import Foundation

struct Comment: Decodable {
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
}
