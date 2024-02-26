//
//  Article.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/26/24.
//

import RealmSwift
import Foundation

class Article: Object, Decodable {
    @objc dynamic var id: Int = 0 // Use as a primary key
    @objc dynamic var publishedDate: String? = nil
    @objc dynamic var title: String? = nil
    @objc dynamic var imageUrl: String? = nil

    override static func primaryKey() -> String? {
        return "id"
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case publishedDate = "published_date"
        case title
        case media
    }

    private enum MediaKeys: String, CodingKey {
        case mediaMetadata = "media-metadata"
    }

    private enum MediaMetadataKeys: String, CodingKey {
        case url
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        publishedDate = try container.decodeIfPresent(String.self, forKey: .publishedDate)
        title = try container.decodeIfPresent(String.self, forKey: .title)

        var mediaArray = try container.nestedUnkeyedContainer(forKey: .media)
        if let firstMedia = try? mediaArray.nestedContainer(keyedBy: MediaKeys.self) {
            var mediaMetadataArray = try firstMedia.nestedUnkeyedContainer(forKey: .mediaMetadata)
            if let firstMediaMetadata = try? mediaMetadataArray.nestedContainer(keyedBy: MediaMetadataKeys.self) {
                imageUrl = try firstMediaMetadata.decodeIfPresent(String.self, forKey: .url)
            }
        }
    }

    required override init() {
        super.init()
    }
}

class ArticlesResponse: Decodable {
    let results: [Article]
}
