//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Anton on 20.06.23.
//

import UIKit
import SafariServices
import FirebaseAuth

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    let logOutButton = UIBarButtonItem()
    
    private let refreshControl = UIRefreshControl()
    private let searchVC = UISearchController(searchResultsController: nil)
    
    var articles = [Article]()
    var viewModels = [NewsTableViewCellViewModel]()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(MainNewsTableViewCell.self, forCellReuseIdentifier: MainNewsTableViewCell.identifier)
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main News"
        
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(searchVC.searchBar)
        
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBar.prefersLargeTitles = true

        fetchTopStories()
        createSearchBar()
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        navigationItem.rightBarButtonItem = logOutButton
        logOutButtonConfigure()
        
    }
    
    @objc private func refreshData() {
        fetchTopStories()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       tableView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
    }
    
    private func fetchTopStories() {
        APICaller.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(
                        title: $0.title,
                        subtitle: $0.description ?? "No Description",
                        imageURL: URL(string: $0.urlToImage ?? "")
                    )
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.refreshControl.endRefreshing()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: TableView settings
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MainNewsTableViewCell.identifier,
            for: indexPath
        ) as? MainNewsTableViewCell else {
            fatalError(debugDescription)
        }
        
        cell.configure(with: viewModels[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) //выделение ячейки пропадает
        let articles = articles[indexPath.row]
        
        guard let url = URL(string: articles.url ?? "") else { return }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    //MARK: BarButtonItem
    
    func logOutButtonConfigure() {
        logOutButton.image = UIImage(systemName: "rectangle.portrait.and.arrow.right")
        logOutButton.style = .plain
        logOutButton.target = self
        logOutButton.action = #selector(logOutButtonPressed)
    }
    
    @objc func logOutButtonPressed() {
        let registrationVC = RegistrationViewController()
        
        do {
            try FirebaseAuth.Auth.auth().signOut()
            print("You signOut")
            registrationVC.delegate = self
            registrationVC.modalPresentationStyle = .fullScreen
            present(registrationVC, animated: true)
        } catch {
            print("An error occured")
        }
    }
    
    // MARK: Search settings
    
    private func createSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        
        APICaller.shared.search(with: text) { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(
                        title: $0.title,
                        subtitle: $0.description ?? "No Description",
                        imageURL: URL(string: $0.urlToImage ?? "")
                    )
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.searchVC.dismiss(animated: true)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MainViewController: RegistrationDelegate {
    func didCompleteRegistration() {
        dismiss(animated: true) { [weak self] in
            self?.fetchTopStories()
            self?.tableView.reloadData()
        }
    }
}


    
    
    

