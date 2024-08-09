//
//  User.swift
//  thirty
//
//  Created by Pranav Medikonduru on 8/9/24.
//

import Foundation


struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
