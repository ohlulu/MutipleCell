//
//  Copyright © 2022 Ohlulu. All rights reserved.
//

import Foundation

class ItemListRepository {
    
    func fetch(completion: @escaping (Result<[ItemModel], Error>) -> Void) {
        let responseData = makeItemEntityJSONData()
        let items = ItemModelMapper.map(responseData)
        completion(.success(items))
    }
    
    func makeItemEntityJSONData() -> Data {
        let items = (1...30).map {
            return [
                "title": "item \($0)",
                "image_url": "https://picsum.photos/id/\($0)/80/80"
            ]
        }
        
        let json = [
            "results": items
        ]
        
        let data = try! JSONSerialization.data(withJSONObject: json)
        return data
    }
}
