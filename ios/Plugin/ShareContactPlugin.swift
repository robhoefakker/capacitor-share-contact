import Foundation
import Capacitor
import UIKit

import Contacts
import ContactsUI


/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(ShareContactPlugin)
public class ShareContactPlugin: CAPPlugin, CNContactViewControllerDelegate, UINavigationControllerDelegate {
    private let implementation = ShareContact()
    private var navigationController = UINavigationController()
    
    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": implementation.echo(value)
        ])
    }
    
    @objc func dismiss(sender: UIButton!){
        print("dismiss now!")
        self.navigationController.dismiss(animated:true)
        }
    
  
    @objc func share(_ call: CAPPluginCall) {

        print("test")
        let contactStore = CNContactStore()
     
        
        contactStore.requestAccess(for: .contacts) { (granted, error) in
                    if let error = error {
                        print("failed to request access", error)
                        call.reject("access denied")
                        return
                    }
                    if granted {
                       do {
                        
                        let name = call.getString("name") ?? ""
                        let phoneNumber = call.getString("phoneNumber") ?? ""
                        let email = call.getString("email") ?? ""
                        let website = call.getString("website") ?? ""
                        let company = call.getString("company") ?? ""
                        let jobTitle = call.getString("jobTitle") ?? ""
                        
                        let contact = CNMutableContact()
                        contact.givenName = name
                        contact.jobTitle = jobTitle
                        contact.organizationName = company
                       
                        let workEmail = CNLabeledValue(label: CNLabelWork, value: email as NSString)
                        contact.emailAddresses = [workEmail]
                    
                        let workWebsite = CNLabeledValue(label: CNLabelWork, value: website as NSString)
                        contact.urlAddresses = [workWebsite]
                    
                  

                        let localizedLabelString = CNLabeledValue<NSString>.localizedString(forLabel: CNLabelPhoneNumberMobile)
                        let phoneNumberParsed = CNPhoneNumber(stringValue: phoneNumber )
                        let labeledPhoneNumber = CNLabeledValue(label: localizedLabelString, value: phoneNumberParsed)
                        contact.phoneNumbers.append(labeledPhoneNumber)
                    
                        let contactViewController = CNContactViewController(forUnknownContact: contact)
                        contactViewController.message = "Added via Dex Cards"
                        contactViewController.contactStore = contactStore
                        contactViewController.allowsActions = true
                        
                     //contactViewController.delegate = self
                        
                        DispatchQueue.main.async {
           
                                  contactViewController.contactStore = CNContactStore()
                            
                            self.navigationController = UINavigationController(rootViewController: contactViewController)
                            //let navigationController = UINavigationController()
//                            navigationController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.dismiss( navigationController:)))
                           // navigationController.delegate = self
                            guard let bridge = self.bridge else { return }
                            let viewController = bridge.viewController!
                            let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: viewController.view.frame.size.width, height: 44))

                           
                            
                            self.navigationController.view.addSubview(navBar)
                            let navItem = UINavigationItem(title: "")
                            navBar.isTranslucent = true
                            navBar.setBackgroundImage(UIImage(), for: .default)
                            navBar.shadowImage = UIImage()
                            let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.dismiss))
                            
                            navItem.rightBarButtonItem = doneItem

                            navBar.setItems([navItem], animated: false)
                            viewController.present(self.navigationController, animated: true)
                            //navigationController.pushViewController(contactViewController, animated: false)
                                  
                            
                            //self.bridge.viewController.present()
                            //self.bridge?.viewController?.navigationController.present(unkvc, animated: true)
                            //self.bridge?.viewController.navigationController.pushViewController.present(unkvc, animated: true)
                        }

                        call.resolve([
                            "results": self.implementation.echo("shared")
                        ])
                       }
                       
                    } else {
                        print("access denied")
                        call.reject("access denied")
                    }
                }
       
    }
    
    func contactViewController(viewController: CNContactViewController, didCompleteWithContact contact: CNContact?) {
        viewController.dismiss(animated: true, completion: nil)
    }
    

    func contactViewController(viewController: CNContactViewController, shouldPerformDefaultActionForContactProperty property: CNContactProperty) -> Bool {
        return true
    }
}
