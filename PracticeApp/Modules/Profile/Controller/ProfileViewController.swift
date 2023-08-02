//
//  ProfileViewController.swift
//  PracticeApp
//
//  Created by Rohit Bharti on 26/07/23.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    private let profileImageView = UIImageView()
    private let containerView = UIView()
    private let userNameLabel = UILabel()
    private let companyLabel = UILabel()
    private let userIdLabel = UILabel()
    private let locationLabel = UILabel()
    private let userTypeLabel = UILabel()
    private let loadingLabel = UILabel()
    private let bioLabel = UILabel()
    private let emailLabel = UILabel()
    private let followersLabel = UILabel()
    private let followingLabel = UILabel()
    private let stackView = UIStackView()
    private let profileViewModel = ProfileViewModel()
    private var name: String
    private var profileData : Profile?
    var isBorderd: Bool = false {
        didSet {
            self.profileViewModel.updateProfileImageBorder(imageView: profileImageView, isBordered: isBorderd)
        }
    }
    
    init(userName: String) {
        self.name = userName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoaderView()
        self.configureViews()
        self.profileViewModel.bindProfileViewModelToController = { data in
            self.profileData = data
            self.setData()
            self.stopLoader()
        }
        self.loadDataFromViewModelOrUserDefaults()
    }
    
    private func setupLoaderView() {
        loadingLabel.text = "Please Wait..."
        self.view.backgroundColor = .white
        self.view.addSubview(loadingLabel)
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 5).isActive = true
        loadingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
        loadingLabel.isHidden = false
        self.view.showLoading()
    }
    
    private func stopLoader() {
        self.loadingLabel.isHidden = true
        self.profileImageView.isHidden = false
        self.followersLabel.isHidden = false
        self.followingLabel.isHidden = false
        self.view.stopLoading()
    }
    
    private func configureViews() {
        configureContainer()
        configureProfileImage()
        setupUIStackView()
        setupFollowersAndFollowing()
    }
    
    private func setupUIStackView() {
        stackView.axis = .vertical
        stackView.spacing = 10.0
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        bioLabel.numberOfLines = 0
//        [
//            self.userIdLabel,
//            self.userNameLabel,
//            self.companyLabel,
//            self.locationLabel,
//            self.userTypeLabel,
//            self.bioLabel,
//            self.emailLabel
//        ].forEach { stackView.addArrangedSubview($0) }
        containerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        stackView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16).isActive = true
        stackView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -16).isActive = true
    }
    
    private func configureContainer() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .black
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    private func configureProfileImage() {
        profileImageView.isHidden = true
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 80 // Making circle
        profileImageView.layer.borderWidth = 4
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.shadowColor = UIColor.darkGray.cgColor
        profileImageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        profileImageView.layer.shadowOpacity = 0.5
        profileImageView.layer.shadowRadius = 4
        self.profileViewModel.updateProfileImageBorder(imageView: profileImageView, isBordered: isBorderd)
        containerView.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        profileImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 120).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 160).isActive = true
    }
    
    private func setupFollowersAndFollowing() {
        followingLabel.isHidden = true
        followersLabel.isHidden = true
        followersLabel.backgroundColor = UIColor(red: 76/255, green: 175/255, blue: 80/255, alpha: 1.0)
        followersLabel.textColor = .white
        followersLabel.font = UIFont.boldSystemFont(ofSize: 16)
        followersLabel.layer.cornerRadius = 12
        followersLabel.clipsToBounds = true
        followersLabel.textAlignment = .center
        containerView.addSubview(followersLabel)

        followingLabel.backgroundColor = UIColor(red: 76/255, green: 175/255, blue: 80/255, alpha: 1.0)
        followingLabel.textColor = .white
        followingLabel.font = UIFont.boldSystemFont(ofSize: 16)
        followingLabel.layer.cornerRadius = 12
        followingLabel.clipsToBounds = true
        followingLabel.textAlignment = .center
        containerView.addSubview(followingLabel)

        followersLabel.translatesAutoresizingMaskIntoConstraints = false
        followingLabel.translatesAutoresizingMaskIntoConstraints = false

        followersLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 32).isActive = true
        followersLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 24).isActive = true
        followersLabel.heightAnchor.constraint(equalToConstant: 48).isActive = true
        followersLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true

        followingLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant:  24).isActive = true
        followingLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -32).isActive = true
        followingLabel.heightAnchor.constraint(equalTo: followersLabel.heightAnchor).isActive = true
        followingLabel.widthAnchor.constraint(equalTo: followersLabel.widthAnchor).isActive = true
    }
    
    private func setData() {
        if let id = profileData?.id {
            userIdLabel.text = "Id: \(id)"
            stackView.addArrangedSubview(userIdLabel)
        }
        
        if let name = profileData?.name {
            userNameLabel.text = "Name: \(name)"
            stackView.addArrangedSubview(userNameLabel)
        }
        
        if let company = profileData?.company {
            companyLabel.text = "Company: \(company)"
            stackView.addArrangedSubview(companyLabel)
        }
        
        if let location = profileData?.location {
            locationLabel.text = "Location: \(location)"
            stackView.addArrangedSubview(locationLabel)
        }
        
        if let type = profileData?.type {
            userTypeLabel.text = "Type: \(type)"
            stackView.addArrangedSubview(userTypeLabel)
        }
        
        if let bio = profileData?.bio {
            bioLabel.text = "Bio: \(bio)"
            stackView.addArrangedSubview(bioLabel)
        }
        
        if let email = profileData?.email {
            emailLabel.text = "Email: \(email)"
            stackView.addArrangedSubview(bioLabel)
        }
        
        if let followers = profileData?.followers {
            followersLabel.text = "Followers: \(followers)"
        }
        
        if let following = profileData?.following {
            followingLabel.text = "Following: \(following)"
        }
        
        ImageDownloader().downloadImage(with: profileData?.avatar_url) { image in
            self.profileImageView.image = image
        }
    }
    
    private func loadDataFromViewModelOrUserDefaults() {
        profileViewModel.loadProfileDataFromUserDefaults(name: self.name)
        configureDeleteButton()
        // If data is not available in UserDefaults, make the API call with default userName
        if profileData == nil {
            configureDownloadButton()
            profileViewModel.callFuncToGetProfileData(name: self.name)
        }
    }
    
    private func configureDownloadButton() {
        let downloadImage = UIImage(named: "download_empty")
        let imageSize = CGSize(width: 34, height: 34)
        let resizedImage = profileViewModel.resizeImage(image: downloadImage!, toSize: imageSize)
        let downloadButton = UIButton(type: .custom)
        downloadButton.setImage(resizedImage, for: .normal)
        downloadButton.addTarget(self, action: #selector(showDownloadConfirmation), for: .touchUpInside)
        let downloadBarButtonItem = UIBarButtonItem(customView: downloadButton)
        navigationItem.rightBarButtonItem = downloadBarButtonItem
    }
    
    private func configureDeleteButton() {
        let deleteIcon = UIImage(named: "download_filled")
        let deleteIconImageSize = CGSize(width: 34, height: 34)
        let deleteIconResizedImage = profileViewModel.resizeImage(image: deleteIcon!, toSize: deleteIconImageSize)
        let deleteButton = UIButton(type: .custom)
        deleteButton.setImage(deleteIconResizedImage, for: .normal)
        deleteButton.addTarget(self, action: #selector(showDeletionConfirmation), for: .touchUpInside)
        let deleteBarButtonItem = UIBarButtonItem(customView: deleteButton)
        navigationItem.rightBarButtonItem = deleteBarButtonItem
    }
    
    @objc private func showDownloadConfirmation() {
        guard let navigationC = self.navigationController, let profileData = self.profileData else {
            return
        }
        let ac = self.profileViewModel.showDownloadConfirmationDialog(name: self.name, profile: profileData, nc: navigationC)
        present(ac, animated: true, completion: nil)
    }
    
    @objc private func showDeletionConfirmation() {
        guard let navigationC = self.navigationController else {
            return
        }
        let ac = self.profileViewModel.showConfirmationDeletionDialog(name: self.name, nc: navigationC)
        present(ac, animated: true, completion: nil)
    }
    
}

