//
//  ProfileViewController.swift
//  MovieKuy
//
//  Created by Raden Dimas on 31/05/22.
//

import UIKit
import FirebaseAuth

enum SectionProfile: Int {
    case Description = 0
    case Email = 1
    case Address = 2
}

final class ProfileViewController: UIViewController {
    
    private lazy var headerView = HeaderProfileView()
    
    let sectionTitles: [String] = ["Description", "Email","Address"]
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cl-cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    private lazy var signOutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Out", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapSignOut), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Profile"
        headerView = HeaderProfileView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 320))
        tableView.tableHeaderView = headerView
        headerView.addSubview(signOutButton)
        setupView()
    }
    
    @objc private func didTapSignOut() {
        AuthManager.shared.signOut()
        let viewController = UINavigationController(rootViewController: SignInViewController())
        viewController.modalPresentationStyle = .fullScreen
        navigationController?.present(viewController, animated: true)
    }
    
    private func setupView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 5),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -5),
            
            signOutButton.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -40),
            signOutButton.widthAnchor.constraint(equalToConstant: 100),
            signOutButton.heightAnchor.constraint(equalToConstant: 40),
            signOutButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor)
            
        ])
    }
}

extension ProfileViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(
            withIdentifier: "cl-cell",
            for: indexPath
        )
        
        var content = cell.defaultContentConfiguration()
        content.textProperties.numberOfLines = 0
        content.textProperties.font = .systemFont(ofSize: 14, weight: .light)
        content.textProperties.alignment = .justified
        switch indexPath.section {
        case SectionProfile.Description.rawValue:
            content.text = "I'm passionate about mobile development, and currently learning SwiftUI, UIKit, Flutter, Machine Learning, and Clean Architecture. I have had experience building several apps with Swift, Flutter and Kotlin."
        case SectionProfile.Email.rawValue:
            content.text = "justdocode012@gmail.com"
        case SectionProfile.Address.rawValue:
            content.text = "Kota Bekasi"
        default:
            return UITableViewCell()
        }
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case SectionProfile.Description.rawValue:
            return 120
        case SectionProfile.Email.rawValue:
            return 50
        case SectionProfile.Address.rawValue:
            return 50
        default:
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
}




