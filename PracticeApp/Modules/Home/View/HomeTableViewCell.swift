//
//  ListTableViewCell.swift
//  PracticeApp
//
//  Created by Rohit Bharti on 27/07/23.
//

import Foundation
import UIKit

class HomeTableViewCell: UITableViewCell {
    let userImageView = UIImageView()
    let userNameLabel = UILabel()
    let userTitleLabel = UILabel()
    let userSubTitleLabel = UILabel()
    let containerView = UIView()
    let subContainerView = UIView()
    let imageContainerView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews() {
        configureContainer()
        configureSubContainer()
        configureImage()
        configureData()
    }
    
    func configureContainer() {
        containerView.backgroundColor = .white
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.borderWidth = 0.5
        containerView.layer.cornerRadius = 10.0
        containerView.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 5
        containerView.layer.shadowOpacity = 1
        self.contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16).isActive = true
        containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16).isActive = true
    }
    
    func configureSubContainer() {
        subContainerView.backgroundColor = .white
        subContainerView.clipsToBounds = true
        subContainerView.layer.cornerRadius = 10.0
        
        containerView.addSubview(subContainerView)
        subContainerView.translatesAutoresizingMaskIntoConstraints = false
        subContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        subContainerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16).isActive = true
        subContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        subContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
    }
    
    func configureImage() {
        userImageView.contentMode = .scaleAspectFill
        userImageView.clipsToBounds = true
        userImageView.layer.cornerRadius = 50
        subContainerView.addSubview(userImageView)
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.leadingAnchor.constraint(equalTo: subContainerView.leadingAnchor, constant: 16).isActive = true
        userImageView.topAnchor.constraint(equalTo: subContainerView.topAnchor, constant: 16).isActive = true
        userImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        userImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        let userImageBottomConstraint = userImageView.bottomAnchor.constraint(lessThanOrEqualTo: subContainerView.bottomAnchor, constant: -16)
        userImageBottomConstraint.priority = .defaultHigh
        userImageBottomConstraint.isActive = true
    }
    
    func configureData() {
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        userNameLabel.numberOfLines = 0
        subContainerView.addSubview(userNameLabel)
        userSubTitleLabel.font = UIFont(name:"HelveticaNeue-Light", size: 18.0)
        userSubTitleLabel.numberOfLines = 0
        containerView.addSubview(userSubTitleLabel)
        
        userTitleLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        userTitleLabel.numberOfLines = 0
        subContainerView.addSubview(userTitleLabel)
        
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 16).isActive = true
        userNameLabel.topAnchor.constraint(equalTo: subContainerView.topAnchor, constant: 8).isActive = true
        userNameLabel.trailingAnchor.constraint(equalTo: subContainerView.trailingAnchor, constant: -16).isActive = true
        userNameLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        userTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        userTitleLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 16).isActive = true
        userTitleLabel.topAnchor.constraint(equalTo: userNameLabel.topAnchor, constant: 32).isActive = true
        userTitleLabel.trailingAnchor.constraint(equalTo: subContainerView.trailingAnchor, constant: -16).isActive = true
        userTitleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        userSubTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        userSubTitleLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 16).isActive = true
        userSubTitleLabel.topAnchor.constraint(equalTo: userTitleLabel.bottomAnchor, constant: 16).isActive = true
        userSubTitleLabel.trailingAnchor.constraint(equalTo: subContainerView.trailingAnchor, constant: -16).isActive = true
        userSubTitleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        let subtitleBottomConstraint = userSubTitleLabel.bottomAnchor.constraint(equalTo: subContainerView.bottomAnchor, constant: -8)
        subtitleBottomConstraint.priority = .defaultLow
        subtitleBottomConstraint.isActive = true
    }
    
    func setLabelAndImage(data: [Users], index : Int) {
        if let userName = data[index].user?.login {
            userNameLabel.text = "\(userName)"
        }
        
        if let title = data[index].title {
            userTitleLabel.text = "\(title)"
        }
        
        if let body = data[index].body {
            userSubTitleLabel.text = "\(body)"
        }
        else {
            userSubTitleLabel.text = nil
        }
        
        ImageDownloader().downloadImage(with: data[index].user?.avatarUrl) { image in
            self.userImageView.image = image
        }
        
    }
}
