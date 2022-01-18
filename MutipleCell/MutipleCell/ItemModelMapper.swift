//
//  Copyright © 2022 Ohlulu. All rights reserved.
//

import Foundation

struct ItemModelMapper {
    
    // MARK: - Structure
    
    private struct ItemEntity: Decodable {
        let results: [Item]
        
        struct Item: Decodable {
            let title: String
            let image_url: URL
        }
    }
    
    // MARK: - Map methods
    
    static func map(_ data: Data) -> [ItemModel] {
        let entity = try! JSONDecoder().decode(ItemEntity.self, from: data)
        return entity.results.map {
            ItemModel(title: $0.title, imageURL: $0.image_url)
        }
    }
}
