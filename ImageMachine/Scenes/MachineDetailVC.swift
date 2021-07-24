//
//  MachineDetailVC.swift
//  ImageMachine
//
//  Created by Ferry Adi Wijayanto on 22/07/21.
//

import UIKit
import Photos
import BSImagePicker

class MachineDetailVC: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let machineIDLbl = PSLabel(text: "Machine ID", fontSize: 18)
    let machineIDNumberLbl = PSBodyLabel(text: "ID Number", fontSize: 16)
    let machineNameLbl = PSLabel(text: "Name", fontSize: 18)
    let machineNameTF = PSTextField(placeholderName: "Machine name")
    let machineTypeLbl = PSLabel(text: "Type", fontSize: 18)
    let machineTypeTF = PSTextField(placeholderName: "Machine type")
    
    let machineQRNumberLbl = PSLabel(text: "QR Number", fontSize: 18)
    
    let machineQRNumberImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let machineMaintenanceDateLbl = PSLabel(text: "Maintenance Date", fontSize: 18)
    let machineMaintenanceDateTF = PSTextField(placeholderName: "Maintenance Date")
    
    let machineMaintenanceDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        return datePicker
    }()
    
    let machineImageLbl = PSLabel(text: "Machine Images", fontSize: 18)
    let machineButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("+Add Image", for: .normal)
        return btn
    }()
    
    var photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var item: MachineItem!
    var store: MachineStore!
    var images: [Data] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.images = self.item.images ?? []
        setupNavigation()
        setupViews()
        setupDatePicker()
        setupCalloutBtn()
        setupItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        photoCollectionView.reloadData()
    }
    
    private func setupItem() {
        title = item.name
        machineIDNumberLbl.text = item.id
        let barcode = UIImage(qrcode: String(item.qrNumber))
        machineQRNumberImageView.image = barcode
        machineNameTF.text = item.name
        machineTypeTF.text = item.type
    }
    
    @objc func addDate(sender: Any, datePicker: UIDatePicker) {
        if let datePicker = machineMaintenanceDateTF.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            machineMaintenanceDateTF.text = dateformatter.string(from: datePicker.date)
        }
        self.machineMaintenanceDateTF.resignFirstResponder()
    }
    
    @objc func pickPhotos() {
        let imagePickerVC = ImagePickerController()
        imagePickerVC.settings.selection.max = 10
        imagePickerVC.settings.theme.selectionStyle = .numbered
        imagePickerVC.settings.fetch.assets.supportedMediaTypes = [.image]
        imagePickerVC.settings.selection.unselectOnReachingMax = true

        self.presentImagePicker(imagePickerVC) { (assets) in
            
        } deselect: { (_) in
            
        } cancel: { (_) in
            
        } finish: { (assets) in
            self.images = self.getImage(from: assets)
            self.photoCollectionView.reloadData()
        }
    }
    
    private func getImage(from assets: [PHAsset]) -> [Data] {
        let images = assets.map { fetchImage(from: $0) }
        return images
    }
    
    private func fetchImage(from asset: PHAsset) -> Data {
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        
        var thumbnail = Data()
        
        manager.requestImage(for: asset, targetSize: .init(width: 100, height: 100), contentMode: .aspectFill, options: options) { (result, info) in
            if let selectedImage = result?.data {
                thumbnail = selectedImage
            }
        }
        return thumbnail
    }

    @objc func saveItem() {
        guard let name = machineNameTF.text else { return }
        guard let type = machineTypeTF.text else { return }
        guard let date = machineMaintenanceDateTF.text else { return }
        
        let machineItem = MachineItem(id: item.id, name: name, type: type, qrNumber: item.qrNumber, maintenanceDate: date, images: images)
        
        store.update(machineItem)
        presentOAlertOnMainThread(title: "Success", message: "Succesfully save machine data", buttonTitle: "OK")
    }
}

extension MachineDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MachineDetailCell.cellID, for: indexPath) as! MachineDetailCell
        
        let image = images[indexPath.row]
        cell.set(imageData: image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = images[indexPath.row]
        presentImageOnMainThread(image: UIImage(data: image)!)
        print(image)
    }
    
}

extension MachineDetailVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 5, height: collectionView.bounds.height / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

// MARK: SetupViews
private extension MachineDetailVC {
    
    func setupNavigation() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveItem))
    }
    
    func setupCalloutBtn() {
        machineButton.addTarget(self, action: #selector(pickPhotos), for: .touchUpInside)
    }
    
    func setupDatePicker() {
        machineMaintenanceDateTF.setInputViewDatePicker(target: self, selector: #selector(addDate(sender:datePicker:)))
    }
    
    func setupViews() {
        let idStackView = UIStackView(arrangedSubviews: [machineIDLbl, machineIDNumberLbl])
        idStackView.distribution = .fillEqually
        idStackView.axis = .vertical
        idStackView.spacing = 8
        
        let nameStackView = UIStackView(arrangedSubviews: [machineNameLbl, machineNameTF])
        nameStackView.distribution = .fillEqually
        nameStackView.axis = .vertical
        nameStackView.spacing = 8
        
        let typeStackView = UIStackView(arrangedSubviews: [machineTypeLbl, machineTypeTF])
        typeStackView.distribution = .fillEqually
        typeStackView.axis = .vertical
        typeStackView.spacing = 8
        
        let dateStackView = UIStackView(arrangedSubviews: [machineMaintenanceDateLbl, machineMaintenanceDateTF])
        dateStackView.distribution = .fillEqually
        dateStackView.axis = .vertical
        dateStackView.spacing = 8
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        [idStackView, nameStackView, typeStackView, machineQRNumberLbl, machineQRNumberImageView, dateStackView, machineImageLbl, machineButton, photoCollectionView].forEach { v in
            contentView.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // CollectionView setup
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photoCollectionView.register(MachineDetailCell.self, forCellWithReuseIdentifier: MachineDetailCell.cellID)
        photoCollectionView.backgroundColor = .systemBackground
        
        let contentViewCenterY = contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        contentViewCenterY.priority = .defaultLow

        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentViewCenterY,
            contentViewHeight,
            
            idStackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 32),
            idStackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            idStackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            idStackView.heightAnchor.constraint(equalToConstant: 52),
            
            nameStackView.topAnchor.constraint(equalTo: idStackView.bottomAnchor, constant: 20),
            nameStackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nameStackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nameStackView.heightAnchor.constraint(equalToConstant: 80),
            
            typeStackView.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: 20),
            typeStackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            typeStackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            typeStackView.heightAnchor.constraint(equalToConstant: 80),
            
            machineQRNumberLbl.topAnchor.constraint(equalTo: typeStackView.bottomAnchor, constant: 20),
            machineQRNumberLbl.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            machineQRNumberLbl.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            machineQRNumberLbl.heightAnchor.constraint(equalToConstant: 20),
            
            machineQRNumberImageView.topAnchor.constraint(equalTo: machineQRNumberLbl.bottomAnchor, constant: 20),
            machineQRNumberImageView.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor),
            machineQRNumberImageView.widthAnchor.constraint(equalToConstant: 150),
            machineQRNumberImageView.heightAnchor.constraint(equalToConstant: 150),
            
            dateStackView.topAnchor.constraint(equalTo: machineQRNumberImageView.bottomAnchor, constant: 20),
            dateStackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            dateStackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            dateStackView.heightAnchor.constraint(equalToConstant: 80),
            
            machineImageLbl.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: 20),
            machineImageLbl.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            machineImageLbl.widthAnchor.constraint(equalToConstant: 132),
            machineImageLbl.heightAnchor.constraint(equalToConstant: 20),
            
            machineButton.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: 20),
            machineButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            machineButton.widthAnchor.constraint(equalToConstant: 120),
            machineButton.heightAnchor.constraint(equalToConstant: 20),
            
            photoCollectionView.topAnchor.constraint(equalTo: machineButton.bottomAnchor, constant: 20),
            photoCollectionView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            photoCollectionView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            photoCollectionView.heightAnchor.constraint(equalToConstant: 160)
            
//            collectionView.topAnchor.constraint(equalTo: containerView.topAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}
