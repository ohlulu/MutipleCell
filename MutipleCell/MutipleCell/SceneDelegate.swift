//
//  Copyright © 2022 Ohlulu. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let repository = ItemListRepository()
        let viewModel = ItemListViewModel(repository: repository)
        window?.rootViewController = ItemListViewController(viewModel: viewModel)
        window?.makeKeyAndVisible()
    }
}
