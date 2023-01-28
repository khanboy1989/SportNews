//
//  ApiEndPoints.swift
//  SportNews
//
//  Created by Serhan Khan on 28.01.23.
//

import Foundation

struct ApiEndPoints {
    
    static func getNewsOverview() -> Endpoint<NewsOverviewResponseDTO>  {
        return Endpoint(path: "templates/generated/1/json/mobile/overview.json",
                        method: .get,
                        responseDecoder: JSONResponseDecoder())
    }
}
