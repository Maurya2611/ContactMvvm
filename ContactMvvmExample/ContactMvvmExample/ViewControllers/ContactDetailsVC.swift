//
//  ContactDetailsVC.swift
//  ContactMvvmExample
//  Created by Chandresh Maurya  on 04/07/2019.
//  Copyright © 2019 Chandresh Maurya . All rights reserved.
//

import UIKit
internal enum ContactViewType {
    case view
    case edit
    case create
}
class ContactDetailsVC: BaseTableViewController<ContactDetailsVM>,
UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    internal var contactViewType: ContactViewType? = .view {
        didSet {
            tableView?.reloadData()
        }
    }
    internal let identifiers = [Cells.profileHeaderCell,
                                Cells.fieldCell,
                                Cells.deleteCell]
    internal let descriptors = [Strings.firstName,
                                Strings.lastName,
                                Strings.mobile,
                                Strings.email]
    lazy var loader: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for identifier in identifiers {
            let nib = UINib(nibName: identifier,
                            bundle: nil)
            tableView?.register(nib,
                                forCellReuseIdentifier: identifier)
        }
        setShadowImageFrom(color: .clear)
        viewModel?.request()
    }
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller. }
     */
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return UITableView.automaticDimension
        }
        return 60
    }
    func tableView(_ tableView: UITableView,
                   estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if contactViewType == .view ||
            contactViewType == .edit {
            return descriptors.count + 2
        }
        return descriptors.count + 1
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let contactId   = identifiers[0]
            let cell = tableView.dequeueReusableCell(withIdentifier: contactId) as? ProfileHeaderCell
            cell?.delegate           = self
            cell?.doUpdateFromType(contactViewType)
            cell?.profileName?.text  = viewModel?.getFullName()
            cell?.setImageFrom(viewModel?.getProfileUrl() ?? "")
            cell?.isFavourite        = viewModel?.getIsFavorite() ?? false
            cell?.separatorInset     = .zero
            cell?.selectionStyle     = .none
            return cell ?? UITableViewCell()
        }
        if indexPath.row == descriptors.count + 1 {
            let contactId   = identifiers[2]
            let cell = tableView.dequeueReusableCell(withIdentifier: contactId) as? DeleteCell
            cell?.delegate           = self
            cell?.separatorInset     = .zero
            cell?.selectionStyle     = .none
            return cell ?? UITableViewCell()
        }
        let row  = indexPath.row - 1
        let contactId   = identifiers[1]
        let cell = tableView.dequeueReusableCell(withIdentifier: contactId) as? FieldCell
        let toolbarTitle            = row == 3 ? Strings.Done : Strings.Next
        let enabled                 = contactViewType == .edit || contactViewType == .create
        cell?.descriptor?.text       = descriptors[row]
        cell?.textField?.placeholder = descriptors[row]
        cell?.textField?.tag         = row
        cell?.textField?.delegate    = self
        cell?.textField?.addDoneCancelToolbar(nextTitle: toolbarTitle)
        cell?.textField?.isUserInteractionEnabled = enabled
        cell?.textField?.text        = viewModel?.getTextFromTag(row)
        cell?.separatorInset = .zero
        cell?.selectionStyle = .none
        
        return cell ?? UITableViewCell()
    }
    //MARK: - TextField Delegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 2 {
            textField.keyboardType = .phonePad
        }
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        viewModel?.setTextFromTag(textField.tag,
                                  text: textField.text ?? "")
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 3 {
            textField.resignFirstResponder()
        }
        let indexPath = IndexPath(row: textField.tag + 2, section: 0)
        if let cell = tableView?.cellForRow(at: indexPath) as? FieldCell {
            cell.textField?.becomeFirstResponder()
        }
        return false
    }
    @IBAction func didTapEditButton(_ sender: UIBarButtonItem) {
        contactViewType = .edit
        createBarButtons()
    }
    @IBAction func didTapDoneButton(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
        if let error = viewModel?.validateEntries() {
            showAlertMessageWithAction(.default,
                                       title: Strings.oops,
                                       message: error.localizedLowercase,
                                       cancelTitle: Strings.Ok,
                                       acceptTitle: nil)
        } else {
            if contactViewType == .create {
                create()
            } else {
                edit()
            }
        }
    }
    @IBAction func didTapCancelButton(_ sender: UIBarButtonItem) {
        if contactViewType == .create {
            self.dismiss(animated: true, completion: nil)
            return
        }
        createViewTypeBarButton()
    }
}
extension ContactDetailsVC {
    func showErrorWith(message: String) {
        self.showAlertMessageWithAction(.default,
                                        title: Strings.oops,
                                        message: message,
                                        cancelTitle: Strings.Ok,
                                        acceptTitle: nil)
    }
    func showSuccessWith(message: String,
                         completion: @escaping (() -> Void)) {
        self.showAlertMessageWithAction(.default,
                                        title: Strings.yey,
                                        message: message,
                                        cancelTitle: nil,
                                        acceptTitle: Strings.Ok,
                                        completion: {
                                            completion()
        })
    }
    func createBarButtons() {
        let doneItem   = UIBarButtonItem.SystemItem.done
        let cancelItem = UIBarButtonItem.SystemItem.cancel
        let done: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: doneItem,
                                                    target: self,
                                                    action: #selector(didTapDoneButton(_:)))
        let cancel: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: cancelItem,
                                                      target: self,
                                                      action: #selector(didTapCancelButton(_:)))
        tableView?.reloadData()
        navigationController?.navigationBar.topItem?.hidesBackButton = true
        navigationController?.navigationBar.topItem?.rightBarButtonItem = done
        navigationController?.navigationBar.topItem?.leftBarButtonItem = cancel
        startResponding()
    }
    func create() {
        startLoader()
        viewModel?.createContact(completion: {[weak self] error in
            guard let self = self else { return }
            guard error == nil else {
                self.showErrorWith(message: Strings.something)
                self.createBarButtons()
                return
            }
            self.showSuccessWith(message: Strings.createdContact,
                                 completion: {
                                    self.dismiss(animated: true, completion: nil)
            })
        })
    }
    func edit() {
        self.showAlertMessageWithAction(.default,
                                        title: Strings.uhm,
                                        message: Strings.override,
                                        cancelTitle: Strings.Cancel,
                                        acceptTitle: Strings.Ok,
                                        completion: {[weak self] in
                                            guard let self = self else { return }
                                            self.startLoader()
                                            self.viewModel?.editContact(completion: { error in
                                                guard error == nil else {
                                                    self.showErrorWith(message: Strings.something)
                                                    self.createBarButtons()
                                                    return
                                                }
                                                self.createViewTypeBarButton()
                                            })
        })
    }
    func startLoader() {
        let barButton = UIBarButtonItem(customView: loader)
        navigationController?.navigationBar.topItem?.rightBarButtonItem = barButton
        loader.startAnimating()
    }
    func startResponding() {
        let indexPath = IndexPath(row: 1, section: 0)
        if let cell = tableView?.cellForRow(at: indexPath) as? FieldCell {
            cell.textField?.becomeFirstResponder()
        }
    }
    func createViewTypeBarButton() {
        var button: UIBarButtonItem?
        contactViewType = .view
        let item = UIBarButtonItem.SystemItem.edit
        button = UIBarButtonItem(barButtonSystemItem: item,
                                 target: self,
                                 action: #selector(didTapEditButton(_:)))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = nil
        navigationController?.navigationBar.topItem?.hidesBackButton   = false
        navigationController?.navigationBar.topItem?.rightBarButtonItem = button
    }
}
extension ContactDetailsVC: ProfileHeaderCellDelegate {
    func doMessage() {
        print("Do Message")
    }
    func doCall() {
        print("Do Call")
    }
    func doEmail() {
        print("Do Email")
    }
    func doFavourite() {
        guard !loader.isAnimating else { return }
        
        viewModel?.updateFavorite(completion: { _ in
            self.createViewTypeBarButton()
        })
    }
}
extension ContactDetailsVC: DeleteCellDelegate {
    func didTapDelete() {
        showAlertMessageWithAction(.destructive,
                                   title: Strings.uhm,
                                   message: Strings.willDelete,
                                   cancelTitle: Strings.Cancel,
                                   acceptTitle: Strings.delete) {[weak self] in
                                    guard let self = self else { return }
                                    self.startLoader()
                                    self.viewModel?.deleteContact(completion: { error in
                                        guard error == nil else {
                                            self.showErrorWith(message: Strings.something)
                                            self.createViewTypeBarButton()
                                            return
                                        }
                                        self.showSuccessWith(message: Strings.successDelete, completion: {
                                            if let _ = self.presentingViewController {
                                                self.dismiss(animated: true,
                                                             completion: nil)
                                            } else {
                                                self.navigationController?.popViewController(animated: true)
                                            }
                                        })
                                    })
        }
    }
}
extension ContactDetailsVC: BaseVMDelegate {
    func didUpdateModel(_ viewModel: BaseVM,
                        withState viewState: ViewState) {
        tableView?.reloadData()
    }
}
