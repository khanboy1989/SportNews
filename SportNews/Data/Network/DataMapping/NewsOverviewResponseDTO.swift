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

struct SportData: Decodable, Hashable {

    let id: Int
    let title: String
    let text: String
    let dateString: String
    let url: String
    let app: String
    let image: Image
    let category: Category
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case text
        case dateString = "date"
        case url
        case app
        case image
        case category
    }
    
    static func == (lhs: SportData, rhs: SportData) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var date: Date? {
        dateString.toDate(withFormat: "yyyy-MM-dd'T'HH:mm:ssZ")
    }
    
    var readableDate: String {
        guard let date = date else { return ""}
        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "dd/MM/YYYY"

        // Convert Date to String
        return dateFormatter.string(from: date)
    }
}

struct Image: Decodable {
    let small: String
    let medium: String
    let large: String
    
    var imageMediumUrl: URL? {
        return URL(string: medium)
    }
    
    var imageLargeUrl: URL? {
        return URL(string: large)
    }
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
