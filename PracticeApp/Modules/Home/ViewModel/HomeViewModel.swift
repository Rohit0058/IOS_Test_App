//
//  UsersViewModel.swift
//  PracticeApp
//
//  Created by Rohit Bharti on 28/07/23.
//

import Foundation

class HomeViewModel {
    private var apiService : HomeAPIService

    var bindUsersViewModelToController : (([Users]?) -> ()) = {_ in }
    
    init() {
        self.apiService = HomeAPIService()
        callFuncToGetUsersData()
    }
    
    func callFuncToGetUsersData() {
        self.apiService.fetchData { (usersData) in
            self.bindUsersViewModelToController(usersData)
        }
    }
}

