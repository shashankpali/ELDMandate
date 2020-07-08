//
//  GenereCollectionViewController.swift
//  Test Shashank Pali
//
//  Created by Shank on 24/06/20.
//  Copyright © 2020 Shank. All rights reserved.
//

import UIKit

private let reuseIdentifier = "GenereCollectionCell"
private let estimatedItemWidth : CGFloat = 170.0
private let margin : CGFloat = 20.0

class GenereCollectionViewController: UICollectionViewController {
    
    private var currentModel = [GenereModel]()
    private var itemArray = [GenereModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleNavBar()
        
        // Register cell classes
        setupCollectionView()
        setupGrid()
        
        // request to API
        fetchData()
    }
    
    // MARK:- UI Updates
    
    func styleNavBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Video Files"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupCollectionView() {
        let nib = UINib(nibName: reuseIdentifier, bundle: .main)
        self.collectionView!.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func setupGrid() {
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        layout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
    
    func reloadCollection() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    // MARK:- Navbar Button Action
    
    @objc func navSearchTapped() {
        // For search functionality
    }
    
    @objc func navBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- Fetch Data
    
    func fetchData() {
        
        Fetch.request(offset: itemArray.count, limit: 16) { (result, errString) in
            if errString != nil {
                let alert = UIAlertController(title: "Error", message: errString, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            self.currentModel = result?.map({ (obj) -> GenereModel in
                GenereModel(response: obj)
            }) ?? []
            
            self.itemArray += self.currentModel
            
            self.reloadCollection()
        }
    }
    
    // MARK:- UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GenereCollectionCell
        
        // Configure the cell
        cell.setupItem(forModel: itemArray[indexPath.row])
        
        return cell
    }
    
    // MARK:- UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let count = itemArray.count
        if (indexPath.row == count - 5) {
            fetchData()
        }
    }
    
}

// MARK:- UICollectionViewDelegateFlowLayout

extension GenereCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellCount = floor(self.collectionView.bounds.width / estimatedItemWidth)
        
        let width = (self.collectionView.bounds.width - ((cellCount - 1) * margin) - (margin * 2)) / cellCount
        
        return CGSize(width: width, height: 160.0)
    }
    
}
