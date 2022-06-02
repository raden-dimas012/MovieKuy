//
//  CardTableViewCell.swift
//  MovieKuy
//
//  Created by Raden Dimas on 01/06/22.
//

import UIKit
import SDWebImage

final class ListTableViewCell: UITableViewCell {

    static let identifier = "ListTableViewCell"
    
    private let playCardButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        return button
    }()
    
    private let cardLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cardPosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(cardPosterImageView)
        contentView.addSubview(cardLabel)
        contentView.addSubview(playCardButton)
        
        NSLayoutConstraint.activate([
            cardPosterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            cardPosterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cardPosterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            cardPosterImageView.widthAnchor.constraint(equalToConstant: 100),
            
            cardLabel.leadingAnchor.constraint(equalTo: cardPosterImageView.trailingAnchor, constant: 20),
            cardLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            cardLabel.widthAnchor.constraint(equalToConstant: 140),
            
            playCardButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playCardButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
      
    }
    
    public func configure(with model: ListViewModel) {
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {
            return
        }
        cardPosterImageView.sd_setImage(with: url, completed: nil)
        cardLabel.text = model.titleName
    }

}
