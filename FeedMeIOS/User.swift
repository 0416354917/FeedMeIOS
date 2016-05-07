//
//  User.swift
//  FeedMeIOS
//
//  Created by Jun Chen on 28/03/2016.
//  Copyright © 2016 FeedMe. All rights reserved.
//

import Foundation

class User: EVObject {
    // MARK: properties
    private var id: Int?
    private var firstname: String?
    private var lastname: String?
    private var birthday: String?
    private var password: String?
    private var registerTime: String?
    private var preferLanguage: String?
    private var photo: String?
    private var phoneNumber: String?
    private var email: String?
    private var title: String?
    private var preferedLanguage: String?
    private var machineCode: String?
    
    // MARK: To be fixed!
    var defaultDeliveryAddress: Address? = Address(userName: "CSIT", addressLine1: "108 N Rd", addressLine2: "Acton", postcode: "2601", phone: "(02) 6125 5111", suburb: "Canberra", state: "ACT", selected: true)
    var deliveryAddresses: [Address]?
    
    // MARK: initialisation methods
    required init() {
        
    }
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    // MARK: setters and getters
    func setFirstName(firstName: String?) {
        self.firstname = firstName
    }
    
    func getFirstName() -> String? {
        return self.firstname
    }
    
    func setLastName(lastName: String?) {
        self.lastname = lastName
    }
    
    func getLastName() -> String? {
        return self.lastname
    }
    
    func setBirthday(birthday: String?) {
        self.birthday = birthday
    }
    
    func getBirthday() -> String? {
        return self.birthday
    }
    
    func setPassword(password: String?) {
        self.password = password
    }
    
    func getPassword() -> String? {
        return self.password
    }
    
    func setRegisterTime(registerTime: String?) {
        self.registerTime = registerTime
    }
    
    func getRegisterTime() -> String? {
        return self.getRegisterTime()
    }
    
    func setPreferLanguage(preferLanguage: String?) {
        self.preferLanguage = preferLanguage
    }
    
    func getPreferLanguage() -> String? {
        return self.preferLanguage
    }
    
    func setPhoto(photo: String?) {
        self.photo = photo
    }
    
    func getPhoto() -> String? {
        return self.photo
    }
    
    func setPhoneNumber(phoneNumber: String?) {
        self.phoneNumber = phoneNumber
    }
    
    func getPhoneNumber() -> String? {
        return self.phoneNumber
    }
    
    func setEmail(email: String?) {
        self.email = email
    }
    
    func getEmail() -> String? {
        return self.email
    }
    
    func setTitle(title: String?) {
        self.title = title
    }
    
    func getTitle() -> String? {
        return self.title
    }
    
    func setPreferedLanguage(preferedLanguage: String?) {
        self.preferedLanguage = preferedLanguage
    }
    
    func getPreferedLanguage() -> String? {
        return self.preferedLanguage
    }
    
    func setMachineCode(machineCode: String?) {
        self.machineCode = machineCode
    }
    
    func getMachineCode() -> String? {
        return self.machineCode
    }
}