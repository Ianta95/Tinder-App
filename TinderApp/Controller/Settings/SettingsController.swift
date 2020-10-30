//
//  SettingsController.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 11/10/20.
//

import UIKit
import JGProgressHUD

private let reusideIdentifier = "SettingsCell"

protocol SettingsControllerDelegate: class {
    func settingsController(_ controller: SettingsController, update user: User)
    func settingsLogout(_ controller: SettingsController)
}

class SettingsController: UITableViewController {
    
    /*------> Componentes <------*/
    private lazy var headerView = SettingsHeader(user: user)
    private let imagePicker = UIImagePickerController()
    private let footerView = SettingsFooter()
    
    /*------> Propiedades <------*/
    private var imageIndex = 0
    private var user: User
    weak var delegate: SettingsControllerDelegate?
    
    init(user: User) {
        self.user = user
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) ha fallado SettingsController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    /*------> Preparativos App <------*/
    // Configura UI
    func configureUI() {
        headerView.delegate = self
        imagePicker.delegate = self
        navigationItem.title = "Configuraciones"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        tableView.separatorStyle = .none
        tableView.tableHeaderView = headerView
        //tableView.rowHeight = 44
        tableView.register(SettingsCell.self, forCellReuseIdentifier: reusideIdentifier)
        print("view.fram.width es \(view.frame.width)")
        tableView.tableFooterView = footerView
        footerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 88 )
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
        footerView.delegate = self
    }
    // Asigna el header
    func setHeaderImage(_ image: UIImage?) {
        headerView.buttons[imageIndex].setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    /*------> Acciones <------*/
    // Cancelar
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    // Aceptar
    @objc func handleDone() {
        print("Click en done")
        view.endEditing(true)
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Guardando data"
        hud.show(in: view)
        Service.saveUserData(user: user) { error in
            self.delegate?.settingsController(self, update: self.user)
        }
    }
    
    /*------> API <------*/
    
    func uploadImage(image: UIImage) {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Guardando imagen"
        hud.show(in: view)
        Service.uploadImage(image: image) { (url) in
            self.user.imageURLs.append(url)
            hud.dismiss()
        }
    }

}

/*------> Delegates <------*/
// Header delegate
extension SettingsController: SettingsHeaderDelegate {
    func settingsHeader(_ header: SettingsHeader, didSelect index: Int) {
        print("Select button es \(index)")
        self.imageIndex = index
        present(imagePicker, animated: true, completion: nil)
    }
}
// Image piccker delegate
extension SettingsController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        uploadImage(image: selectedImage)
        setHeaderImage(selectedImage)
        dismiss(animated: true, completion: nil)
    }
}

// Tableview Datasource
extension SettingsController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSections.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusideIdentifier, for: indexPath) as! SettingsCell
        guard let section = SettingsSections(rawValue: indexPath.section) else { return cell }
        let viewModel = SettingsViewModel(user: user, section: section )
        cell.viewModel = viewModel
        cell.contentView.isUserInteractionEnabled = false
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
    
    
}
// Tableview Datasource
extension SettingsController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = SettingsSections(rawValue: section) else { return nil }
        return section.description
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = SettingsSections(rawValue: indexPath.section) else { return 0 }
        return section == .ageRange ? 96 : 44
    }
    
}

// Settings Delegate
extension SettingsController: SettingsCellDelegate {
    func settingsCell(_ cell: SettingsCell, updateAgeWith sender: UISlider) {
        if sender == cell.minAgeSlider {
            user.minSeekingAge = Int(sender.value)
        } else {
            user.maxSeekingAge = Int(sender.value)
        }
    }
    
    
    func settingsCell(_ cell: SettingsCell, updateUserWith value: String, for section: SettingsSections) {
        switch section {
        case .name:
            user.name = value
        case .profession:
            user.profession = value
        case .age:
            user.age = Int(value) ?? user.age
        case .bio:
            user.bio = value
        case .ageRange:
            break
        }
    }

}

// Settings Footer Delegate
extension SettingsController: SettingsFooterDelegate {
    func settingsLogout() {
        print("Click logout")
        delegate?.settingsLogout(self)
    }
}
