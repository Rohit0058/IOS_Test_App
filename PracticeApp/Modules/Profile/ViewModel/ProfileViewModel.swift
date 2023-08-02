//
//  ProfileViewModel.swift
//  PracticeApp
//
//  Created by Rohit Bharti on 28/07/23.
//

import Foundation
import UIKit

class ProfileViewModel {
    private var apiService : ProfileAPIService
    
    var bindProfileViewModelToController : ((Profile?) -> ()) = {_ in }
    
    init() {
        self.apiService = ProfileAPIService()
    }
    
    func callFuncToGetProfileData(name: String) {
        self.apiService.fetchData(userName: name) { (profileData) in
            self.bindProfileViewModelToController(profileData)
            print("Data Fetched From Profile API for: \(name)")
        }
    }
    
    func loadProfileDataFromUserDefaults(name: String) {
        if let loadedData = getDataFromUserDefaults(forKey: name) {
            self.bindProfileViewModelToController(loadedData)
            print("Data Loaded From UserDefaults for: \(String(describing: loadedData.name))")
        }
    }
    
    func getDataFromUserDefaults(forKey key: String) -> Profile? {
        if let data = UserDefaults.standard.data(forKey: key) {
            do {
                let decodedPerson = try JSONDecoder().decode(Profile.self, from: data)
                return decodedPerson
            } catch {
                print("Error decoding struct object: \(error)")
            }
        }
        return nil
    }
    
    func saveProfileDataToUserDefaults(name: String, profile: Profile) {
        do {
            let encodedData = try JSONEncoder().encode(profile)
            UserDefaults.standard.set(encodedData, forKey: name)
            print("Data is saved in User Defaults for: \(name)")
            UserDefaults.standard.synchronize()
        } catch {
            print("Error encoding struct object: \(error)")
        }
    }
    
    func deleteProfileDataToUserDefaults(name: String) {
        UserDefaults.standard.removeObject(forKey: name)
        print("Data is Deleted from User Defaults for: \(name)")
    }
    
    func showDownloadConfirmationDialog(name: String, profile: Profile, nc: UINavigationController) -> UIAlertController {
        let alertController = UIAlertController(title: "",
                                                message: "Data is Downloaded",
                                                preferredStyle: .actionSheet)
        self.saveProfileDataToUserDefaults(name: name, profile: profile)
        let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
            self?.dismissSelf(nc: nc)
        }
        alertController.addAction(okAction)
        return alertController
    }
    
    func showConfirmationDeletionDialog(name: String, nc: UINavigationController) -> UIAlertController {
        let alertController = UIAlertController(title: "Confirmation",
                                                message: "Are you sure you want to Delete?",
                                                preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
            self?.deleteProfileDataToUserDefaults(name: name)
            self?.dismissSelf(nc: nc)
        }
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        return alertController
    }
    
    func dismissSelf(nc: UINavigationController) {
        nc.popViewController(animated: true)
    }
    
    func updateProfileImageBorder(imageView: UIImageView, isBordered: Bool) {
        if isBordered {
            // Adding border
            imageView.layer.borderWidth = 0.5
            imageView.layer.borderColor = UIColor.black.cgColor
            let pattern: [NSNumber] = [4, 4]
            let borderLayer = CAShapeLayer()
            borderLayer.lineDashPattern = pattern
            borderLayer.frame = imageView.bounds
            borderLayer.fillColor = nil
            borderLayer.path = UIBezierPath(rect: imageView.bounds).cgPath
            imageView.layer.addSublayer(borderLayer)
        } else {
            // Remove border
            imageView.layer.borderWidth = 0
            imageView.layer.borderColor = UIColor.clear.cgColor
            // Remove any existing border layer
            imageView.layer.sublayers?.forEach { sublayer in
                if sublayer is CAShapeLayer {
                    sublayer.removeFromSuperlayer()
                }
            }
        }
    }
    
    func resizeImage(image: UIImage, toSize size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        image.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage ?? image
    }
    
}
