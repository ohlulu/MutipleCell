//
//  Copyright © 2022 Ohlulu. All rights reserved.
//

import UIKit
import Combine

final class ItemCell: UICollectionViewCell {
    
    private lazy var imageView = UIImageView()
    private lazy var titleLabel = UILabel()
    private var cancellable = Set<AnyCancellable>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ItemCell {
    
    func config(model: ItemModel) {
        
        titleLabel.text = model.title
        URLSession.shared.dataTaskPublisher(for: model.imageURL)
            .map { (data, _) -> UIImage in return UIImage(data: data) ?? UIImage() }
            .catch { _ in return Just(UIImage()) }
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: imageView)
            .store(in: &cancellable)

    }
}

private extension ItemCell {
    
    func setupUI() {
        
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 24) / 2),
            imageView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 24) / 2)
        ])

        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
