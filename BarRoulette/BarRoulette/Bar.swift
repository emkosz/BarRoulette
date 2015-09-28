//
//  Bar.swift
//  BarRoulette
//
//  Created by Emma Koszinowski on 8/13/15.
//  Copyright (c) 2015 Emma Koszinowski. All rights reserved.
//

import Foundation

struct Bar: CustomStringConvertible {
    static func create(snippet snippet: String?, imageURL: NSURL?, coordinate: Coordinate?) -> Bar? {
        if let x = snippet, y = imageURL, z = coordinate {
            return Bar(snippet: x, imageURL: y, coordinate: z)
        }
        return nil
    }
    
    let snippet: String
    let imageURL: NSURL
    
    let coordinate: Coordinate
    
    var description: String {
        return "{ snippet: \(snippet), imageURL: \(imageURL), coordinate: \(coordinate) }"
    }
}


// Coordinate.create(latitude: "43", longitude: "-70")

struct Coordinate: CustomStringConvertible {
    static func create(latitude latitude: Double?, longitude: Double?) -> Coordinate? {
        if let x = latitude, y = longitude {
            return Coordinate(latitude: x, longitude: y)
        }
        return nil
    }
    
    let latitude: Double
    let longitude: Double
    
    
    var description: String {
        return "(\(latitude),\(longitude))"
    }
}
