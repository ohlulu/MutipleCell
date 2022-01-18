//
//  Copyright © 2022 Ohlulu. All rights reserved.
//

import Foundation

class ItemListViewModel {
    
    private let repository: ItemListRepository
    
    init(repository: ItemListRepository) {
        self.repository = repository
    }
    
    func fetch(completion: @escaping (Result<[ItemModel], Error>) -> Void) {
        repository.fetch(completion: completion)
    }
}
