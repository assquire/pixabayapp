//
//  ViewController.swift
//  PixabayApp
//
//  Created by Askar on 14.02.2023.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    private lazy var contentView = UIView()
    private var mediaType: MediaType = .image
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [MediaType.image.rawValue, MediaType.video.rawValue])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        searchBar.resignFirstResponder()
        return searchBar
    }()
    
    private lazy var mediaCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MediaCollectionViewCell.self, forCellWithReuseIdentifier: Constants.Identifiers.mediaCollectionViewCell)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureNavBar()
        
        mediaCollectionView.dataSource = self
        mediaCollectionView.delegate = self

        setupViews()
        setupConstraints()
    }
}

//MARK: - Private view controller methods

private extension MainViewController {
    func configureNavBar() {
        navigationItem.title = "Movies & Images"
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            mediaType = .image
            mediaCollectionView.reloadData()
        } else {
            mediaType = .video
            mediaCollectionView.reloadData()
        }
    }
}

//MARK: - Collection view data source methods

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.mediaCollectionViewCell, for: indexPath) as! MediaCollectionViewCell
        if mediaType == .image {
            cell.backgroundColor = Constants.Colors.imageCell
        } else {
            cell.backgroundColor = Constants.Colors.videoCell
        }
        cell.configure(with: mediaType)
        cell.layer.cornerRadius = 8
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width/2.06
        return CGSize(width: width, height: width*1.12)
    }
}

//MARK: - Setup views and constraints

private extension MainViewController {
    
    func setupViews() {
        view.addSubview(contentView)
        contentView.addSubview(searchBar)
        contentView.addSubview(segmentedControl)
        contentView.addSubview(mediaCollectionView)
    }
    
    func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        segmentedControl.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        searchBar.searchTextField.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        mediaCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}


