//
//  YoutubeResponse.swift
//  MovieKuy
//
//  Created by Raden Dimas on 01/06/22.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
