//
//  MediaCollectionViewCell.swift
//  PixabayApp
//
//  Created by Askar on 14.02.2023.
//

import UIKit

final class MediaCollectionViewCell: UICollectionViewCell {
    
    private lazy var mediaImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .label
        label.text = "Name"
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with mediaType: MediaType) {
        if mediaType == .image {
            mediaImageView.image = UIImage(named: "car")
            mediaImageView.contentMode = .scaleToFill
        } else {
            mediaImageView.image = UIImage(systemName: "play.circle.fill")
            mediaImageView.contentMode = .scaleAspectFit
        }
    }
}

//MARK: - Setup views and constraints

private extension MediaCollectionViewCell {
    
    func setupViews() {
        contentView.addSubview(mediaImageView)
        contentView.addSubview(nameLabel)
    }
    
    func setupConstraints() {
        mediaImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(mediaImageView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

