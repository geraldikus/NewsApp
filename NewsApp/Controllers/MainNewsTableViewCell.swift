//
//  MainNewsTableViewCell.swift
//  NewsApp
//
//  Created by Anton on 20.06.23.
//

import UIKit

class MainNewsTableViewCellViewModel {
    let title: String
    let subtitle: String
    let imageURL: URL?
    let imageData: Data? = nil
    
    init(title: String, subtitle: String, imageURL: URL?) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }
}

class MainNewsTableViewCell: UITableViewCell {

    static let identifier = "MainNewsTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: MainNewsTableViewCellViewModel) {
        
    }
}
