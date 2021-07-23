//
//  MachineDataVC.swift
//  ImageMachine
//
//  Created by Ferry Adi Wijayanto on 22/07/21.
//

import UIKit

protocol MachineDataDelegate {
    func didSave(image assets: [Data])
}

class MachineDataVC: UIViewController {
    
    var tableView = UITableView()
    var store = MachineStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTableView()
        
        let item = MachineItem(name: "Mac", type: "Laptop")
        store.add(item, at: 0)
    }
    
    @objc private func addItems() {
        print("add item")
        let alert = PSAlertVC()
        alert.modalTransitionStyle = .crossDissolve
        alert.modalPresentationStyle = .overFullScreen
        
        alert.closure = { [weak self] name, type in
            guard let self = self else { return }
            let machineItem = MachineItem(name: name, type: type)
            
            self.store.add(machineItem, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
        present(alert, animated: true)
    }
    
    func sortItem() -> UIMenu {
      
      let sortName = UIAction(
        title: "Name",
        image: nil
      ) { (_) in
        self.store.items.sort { $0.name > $1.name }
        self.tableView.reloadData()
      }
      
      let sortType = UIAction(
        title: "Type",
        image: nil
      ) { (_) in
        self.store.items.sort { $0.type > $1.type }
        self.tableView.reloadData()
      }
      
      let menuActions = [sortName, sortType]
      
      let addNewMenu = UIMenu(
        title: "",
        children: menuActions)
      
      return addNewMenu
    }
}

extension MachineDataVC: MachineDataDelegate {
    func didSave(image assets: [Data]) {
        store.items.forEach { item in
            let machineItem = MachineItem(id: item.id, name: item.name, type: item.type, qrNumber: item.qrNumber, maintenanceDate: String(item.qrNumber), images: assets)
            store.items.append(machineItem)
        }
    }
}

// MARK: Extension TableView
extension MachineDataVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MachineCell.cellID, for: indexPath) as! MachineCell
        cell.accessoryType = .disclosureIndicator
        
        let machine = store.items[indexPath.row]
        
        cell.set(item: machine)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = store.items[indexPath.row]
        
        let detailVC = MachineDetailVC()
        detailVC.item = item
        detailVC.store = store
        navigationController?.pushViewController(detailVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            store.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            break
        }
    }
    
}

// MARK: Extension SetupViews
private extension MachineDataVC {
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.frame         = view.bounds
        tableView.rowHeight     = 80
        tableView.delegate      = self
        tableView.dataSource    = self
        tableView.register(MachineCell.self, forCellReuseIdentifier: MachineCell.cellID)
    }
    
    private func setupNavigation() {
        title = "Image Machine"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItems))
        let sort = UIBarButtonItem(title: "Sort", image: nil, primaryAction: nil, menu: sortItem())
        navigationItem.rightBarButtonItems = [addItem, sort]
    }
    
}
