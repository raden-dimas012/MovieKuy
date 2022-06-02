//
//  HeaderProfileView.swift
//  MovieKuy
//
//  Created by Raden Dimas on 01/06/22.
//

import UIKit
import FirebaseAuth

final class HeaderProfileView: UIView {
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "MyPhoto")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 75
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Raden Dimas"
        return label
    }()
    
    private lazy var jobLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "iOS Developer"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(jobLabel)
//        profileImageView.circular()
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor,constant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 150),
            profileImageView.widthAnchor.constraint(equalToConstant: 150),
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
          
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor,constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            jobLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 10),
            jobLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
        ])
    }
}
