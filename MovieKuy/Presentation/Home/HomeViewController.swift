//
//  HomeViewController.swift
//  MovieKuy
//
//  Created by Raden Dimas on 30/05/22.
//

import UIKit
import FirebaseAuth

enum SectionHome: Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
}

final class HomeViewController: UIViewController {
    
    let sectionTitles: [String] = ["Trending Movies", "Trending Tv", "Popular"]
    
    private lazy var homeTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Home"
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        handleAuth()
    }
    
    private func handleAuth() {
        if Auth.auth().currentUser == nil {
            let viewController = UINavigationController(rootViewController: SignInViewController())
            viewController.modalPresentationStyle = .fullScreen
            navigationController?.present(viewController, animated: true)
        }
    }
    
    private func setupView() {
        view.addSubview(homeTableView)
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        NSLayoutConstraint.activate([
            homeTableView.topAnchor.constraint(equalTo: view.topAnchor),
            homeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            homeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 5),
            homeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -5),
        ])
    }
}

extension HomeViewController: UITableViewDelegate,UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as? CollectionTableViewCell else {
            return UITableViewCell()
        }

        cell.delegate = self

        switch indexPath.section {
        case SectionHome.TrendingMovies.rawValue:
            APIManager.shared.getTrendingMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }
        case SectionHome.TrendingTv.rawValue:
            APIManager.shared.getTrendingTvs { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }
        case SectionHome.Popular.rawValue:
            APIManager.shared.getPopular { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }
        default:
            return UITableViewCell()

        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
}

extension HomeViewController: CollectionTableViewCellDelegate {
    func collectionTableViewCellDidTapCell(_ cell: CollectionTableViewCell, viewModel: DetailViewModel) {
        DispatchQueue.main.async { [weak self] in
            let viewController = DetailViewController()
            viewController.configure(with: viewModel)
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
