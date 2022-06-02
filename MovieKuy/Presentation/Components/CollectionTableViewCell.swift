//
//  CollectionTableViewCell.swift
//  MovieKuy
//
//  Created by Raden Dimas on 01/06/22.
//

import Foundation
import UIKit

protocol CollectionTableViewCellDelegate: AnyObject {
    func collectionTableViewCellDidTapCell(_ cell: CollectionTableViewCell, viewModel: DetailViewModel)
}

final class CollectionTableViewCell: UITableViewCell {
    
    static let identifier = "CollectionTableViewCell"
    private var titles: [Title] = [Title]()
    weak var delegate: CollectionTableViewCellDelegate?
    
    private lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140,height: 200)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(RowCollectionViewCell.self, forCellWithReuseIdentifier: RowCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)        
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupCollectionView() {
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    private func addToFavoriteAt(indexPath: IndexPath) {
        CoreDataManager.shared.addToFavorite(model: titles[indexPath.row]) { result in
               switch result {
               case .success():
                   NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
               case .failure(let error):
                   print(error.localizedDescription)
               }
           }
       }
    
    public func configure(with titles: [Title]) {
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension CollectionTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RowCollectionViewCell.identifier, for: indexPath) as? RowCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let model = titles[indexPath.row].poster_path else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else {
            return
        }
        
        
        APIManager.shared.getMovie(with: titleName + " trailer") { [weak self] result in
            switch result {
            case .success(let videoElement):
                
                let title = self?.titles[indexPath.row]
                guard let titleOverview = title?.overview else {
                    return
                }
                guard let strongSelf = self else {
                    return
                }
                let viewModel = DetailViewModel(title: titleName, youtubeView: videoElement, titleOverview: titleOverview)
                self?.delegate?.collectionTableViewCellDidTapCell(strongSelf, viewModel: viewModel)
//                debugPrint(videoElement.id)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
         
         let config = UIContextMenuConfiguration(
             identifier: nil,
             previewProvider: nil) {[weak self] _ in
                 let downloadAction = UIAction(title: "Add to favorite", subtitle: nil, image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                     self?.addToFavoriteAt(indexPath: indexPath)
                 }
                 return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
             }
         
         return config
     } // for action in cell for download
     
    
    
}

