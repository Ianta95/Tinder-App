//
//  MessagesController.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 07/01/21.
//

import UIKit

private let reuseIdentifier = "CellChat"

class MessagesController: UITableViewController {
    /*------> Propiedades <------*/
    private let user: User
    
    /*------> Componentes <------*/
    private let headerView = MatchHeader()
    
    /*------> Ciclo App <------*/
    // Init
    init(user: User) {
        self.user = user
        super.init(style: .plain)
    }
    // Did Load
    override func viewDidLoad() {
        configureTableView()
        configureNavigationBar()
    }
    // Required
    required init?(coder: NSCoder) {
        fatalError("init(coder:) no pudo ser implementado")
    }
    /*------> Preparativos App <------*/
    // Configura chats
    func configureTableView(){
        tableView.rowHeight = 80
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        tableView.tableHeaderView = headerView
    }
    // Configura barra navegacion
    func configureNavigationBar(){
        let leftButton = UIImageView()
        leftButton.setDimensions(height: 28, width: 28)
        leftButton.isUserInteractionEnabled = true
        leftButton.image = #imageLiteral(resourceName: "app_icon").withRenderingMode(.alwaysTemplate)
        leftButton.tintColor = .lightGray
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        leftButton.addGestureRecognizer(tap)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        let icon = UIImageView(image: #imageLiteral(resourceName: "top_messages_icon").withRenderingMode(.alwaysTemplate))
        icon.tintColor = .systemPink
        navigationItem.titleView = icon
    }
    
    /*------> Acciones <------*/
    @objc func handleDismissal(){
        dismiss(animated: true, completion: nil)
    }
    
}


// Data source
extension MessagesController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
}

// Delegate
extension MessagesController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 0.18176651, blue: 0.5282604098, alpha: 1)
        label.text = "Mensajes"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(label)
        label.centerY(inView: view, leftAnchor: view.leftAnchor, paddingLeft: 12)
        return view
        
    }
}
