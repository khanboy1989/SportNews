//
//  NewsOverviewResponseDTO.swift
//  SportNews
//
//  Created by Serhan Khan on 28.01.23.
//

import Foundation

struct NewsOverviewResponseDTO: Decodable {
    let type: String
    let analytics: Analytics
    let data: MainData
}

struct Analytics: Decodable {
    let oewa: String
    let google: String
}

struct MainData: Decodable{
    let fussball: [Fussball]
    let wintersport: [WinterSport]
    let motorsport: [MotorSport]
    let sportmix: [SportMix]
    let esports: [Esports]
}

struct Fussball: Decodable {
    let type: String
    let data: SportData
}

struct WinterSport: Decodable {
    let type: String
    let data: SportData
}

struct MotorSport: Decodable {
    let type: String
    let data: SportData
}

struct SportMix: Decodable {
    let type: String
    let data: SportData
}

struct Esports: Decodable {
    let type: String
    let data: SportData
}

struct SportData: Decodable {
    let id: Int
    let title: String
    let text: String
    let date: String
    let url: String
    let app: String
    let image: Image
    let category: Category
}

struct Image: Decodable {
    let small: String
    let medium: String
    let large: String
}

struct Category: Decodable {
    let filterId: Int
    let filterTitle: String
    let id: Int
    let title: String
    let icon: String
}

struct Posting: Decodable {
    let id: Int
    let count: Int
}
