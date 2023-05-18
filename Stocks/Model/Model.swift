//
//  Model.swift
//  Stocks
//
//  Created by Nurbakhyt on 12.05.2023.
//

import Foundation

struct Disney: Decodable {
    let info: Info?
    let data: [GetData]
}

struct Info: Decodable {
    let count: Int?
    let totalPages: Int?
    let nextPage: String
}

struct GetData: Decodable {
    let _id: Int
    let films: [String]?
    let shortFilms: [String]?
    let videoGames: [String]?
    let name: String?
    let imageUrl: String?

}


