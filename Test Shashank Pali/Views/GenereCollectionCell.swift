//
//  GenereCollectionCell.swift
//  Test Shashank Pali
//
//  Created by Shank on 24/06/20.
//  Copyright © 2020 Shank. All rights reserved.
//

import UIKit

class GenereCollectionCell: UICollectionViewCell {

    @IBOutlet weak var itemImgView: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var fileSizeLabel: UILabel!
    @IBOutlet weak var statusImgView: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from urlStr: String) {
        let url = URL(string: urlStr)!
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.indicator.stopAnimating()
                self?.itemImgView.image = UIImage(data: data)
            }
        }
    }
    
    func setupItem(forModel model: GenereModel) {
        itemLabel.text = model.title
        fileSizeLabel.text = model.size
        statusImgView.image = UIImage(named: model.status)
        
        downloadImage(from: model.imgURL)
    }
}
