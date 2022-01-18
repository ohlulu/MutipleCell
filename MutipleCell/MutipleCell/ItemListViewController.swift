//
//  Copyright © 2022 Ohlulu. All rights reserved.
//

import UIKit

final class ItemListViewController: UIViewController {
    
    private lazy var collectionView = makeCollectionView()
    private var items = [ItemModel]()
    private let viewModel: ItemListViewModel
    
    init(viewModel: ItemListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadItems()
    }
}

private extension ItemListViewController {
    
    func loadItems() {
        viewModel.fetch { result in
            if let items = try? result.get() {
                self.items = items
                self.collectionView.reloadData()
            }
        }
    }
}

extension ItemListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let c = UICollectionViewCell()
//        c.contentView.backgroundColor = .red
//        return c
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: ItemCell.self, for: indexPath)
        cell.config(model: items[indexPath.row])
        return cell
    }
}

private extension ItemListViewController {
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func makeCollectionView() -> UICollectionView {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.minimumLineSpacing = 8
        flowLayout.sectionInset = .init(top: 8, left: 8, bottom: 8, right: 8)
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.scrollDirection = .vertical
        
        let collecionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collecionView.registerCell(type: ItemCell.self)
        collecionView.dataSource = self
        return collecionView
    }
}

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(type: T.Type) {
        register(type, forCellWithReuseIdentifier: String(describing: type))
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: type), for: indexPath) as! T
    }
}
