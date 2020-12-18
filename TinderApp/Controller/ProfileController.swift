//
//  ProfileController.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 29/10/20.
//

import UIKit

private let reuseIdentifier = "ProfileCell"

class ProfileController: UIViewController {
    /*------> Variables <------*/
    private let user: User
    private lazy var viewModel = ProfileViewModel(user: user)
    
    /*------> Componentes <------*/
    private lazy var collectionView: UICollectionView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: frame, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.register(ProfileCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        return cv
    }()
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "dismiss_down_arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Nombre del usuario"
        return label
    }()
    private let professionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Profession del usuario"
        return label
    }()
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Breve descrpición del usuario"
        return label
    }()
    private let bottomButtonsStack = BottomControlsStackView(refresh: false, dislike: true, superLike: true, like: true, boost: false)
    /*------> Override <------*/
    // Init
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    // Required init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) en ProfileController no se inicio de manera correcta")
    }
    
    // View Did load
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    /*------> Configuraciones APP <------*/
    // UI
    private func configureUI(){
        view.backgroundColor = .white
        // Añadir imagenes
        view.addSubview(collectionView)
        // Añadir dismiss button
        view.addSubview(dismissButton)
        dismissButton.setDimensions(height:  40, width: 40)
        dismissButton.anchor(top: collectionView.bottomAnchor, right: view.rightAnchor, paddingTop:  -20, paddingRight: 16 )
        // Añadir info
        let infoStack = UIStackView(arrangedSubviews: [infoLabel, professionLabel,  bioLabel])
        infoStack.axis = .vertical
        infoStack.spacing = 4
        view.addSubview(infoStack)
        infoStack.anchor(top: collectionView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
        // Aádir botones inferiores
        view.addSubview(bottomButtonsStack)
        bottomButtonsStack.setDimensions(height: 80, width: 300)
        bottomButtonsStack.centerX(inView: view)
        bottomButtonsStack.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 32)
    }
    private func configureBottomControls() {
        
    }
    /*------> Actions <------*/
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
}
/*------> Data Source <------*/
extension ProfileController: UICollectionViewDataSource {
    // Items de la sección
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imageCount
        
        //TODO me quede aqui
    }
    // Celdas de la sección
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        if (indexPath.row == 0) {
            cell.backgroundColor = .red
        } else {
            cell.backgroundColor = .blue
        }
        return cell
    }
    
    
}
/*------> Delegate <------*/
extension ProfileController: UICollectionViewDelegate {
    
}
/*------> Flow Delegate*/
extension ProfileController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
