//
//  ApiEndPoints.swift
//  SportNews
//
//  Created by Serhan Khan on 28.01.23.
//

import Foundation

//API EndPoints are defined here
struct ApiEndPoints {
    
    //GetNewsOverview endpoint
    //Here we decide what kind of decoder we need
    //Raw data, JsonResponseDecodera and etc.
    //If we need only data we can handle it from here
    static func getNewsOverview() -> Endpoint<NewsOverviewResponseDTO>  {
        return Endpoint(path: "templates/generated/1/json/mobile/overview.json",
                        method: .get,
                        responseDecoder: JSONResponseDecoder())
    }
}
