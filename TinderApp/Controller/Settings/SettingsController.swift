//
//  SettingsController.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 11/10/20.
//

import UIKit

class SettingsController: UITableViewController {
    
    /*------> Componentes <------*/
    private let headerView = SettingsHeader()
    private let imagePicker = UIImagePickerController()
    /*------> Propiedades <------*/
    private var imageIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        //view.backgroundColor = UIColor(white: 1, alpha: 1)
    }
    /*------> Preparativos App <------*/
    // Configura UI
    func configureUI() {
        headerView.delegate = self
        imagePicker.delegate = self
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        tableView.separatorStyle = .none
        tableView.tableHeaderView = headerView
        print("view.fram.width es \(view.frame.width)")
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
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
    }
    


}

/*------> Delegates <------*/
extension SettingsController: SettingsHeaderDelegate {
    func settingsHeader(_ header: SettingsHeader, didSelect index: Int) {
        print("Select button es \(index)")
        self.imageIndex = index
        present(imagePicker, animated: true, completion: nil)
    }
}

extension SettingsController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[.originalImage] as? UIImage
        setHeaderImage(selectedImage)
        dismiss(animated: true, completion: nil)
    }
}
