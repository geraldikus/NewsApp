//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Anton on 20.06.23.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let model = APIResponse(articles: [Article]())
    
    let mainLabel = UILabel()
    
    private var viewModels = [MainNewsTableViewCellViewModel]()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(MainNewsTableViewCell.self, forCellReuseIdentifier: MainNewsTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainLabel.text = "Main News"
        view.backgroundColor = .systemBackground
        
        view.addSubview(mainLabel)
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        mainLabel.frame = CGRect(x: 10, y: 70, width: 400, height: 40)
        mainLabel.font = UIFont(name: "Georgia", size: 40)
        mainLabel.font = UIFont.boldSystemFont(ofSize: 40)
        
        APICaller.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):
                self?.viewModels = articles.compactMap({
                    MainNewsTableViewCellViewModel(
                        title: $0.title,
                        subtitle: $0.description ?? "No Description",
                        imageURL: URL(string: $0.urlToImage ?? "")
                    )
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = CGRect(x: 0, y: 130, width: view.bounds.width, height: view.bounds.height - 160) // нужно поправить размер tableView, чтобы он не наезжал на tabBar
    }
    
    // MARK: TableView settings
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        return model.articles.count
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
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}



    
    
    

