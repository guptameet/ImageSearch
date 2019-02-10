//
//  PictureSearchViewController.swift.swift
//  ImageSearch
//
//  Created by Meet on 2/9/19.
//  Copyright © 2019 Meet. All rights reserved.
//

import UIKit

class PictureSearchViewController: UIViewController {

    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    @IBOutlet weak var queryTextField: UITextField!

    fileprivate let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.5, bottom: 0.0, right: 0.0)

    fileprivate var viewModel: PictureViewerViewModel? {
        didSet {
            refreshView()
        }
    }
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorView: UIView!
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupCollectionView()
        viewModel = PictureViewerViewModel()
        viewModel?.pictures.bind(listner: {[weak self] (pictures) in
            self?.isLoading = false
            self?.imageCollectionView.reloadData()
        })
    }

    fileprivate func setupCollectionView() {
        
        imageCollectionView.register(UINib(nibName: String(describing: PictureCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: PictureCell.self))
    }
    
    fileprivate func refreshView() {
        imageCollectionView.reloadData()
    }
    
    @IBAction func searchClicked(_ sender: Any) {
        isLoading = true
        viewModel?.queryString = queryTextField.text ?? ""
        queryTextField.endEditing(true)
    }
}


extension PictureSearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.pictures.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PictureCell.self), for: indexPath) as! PictureCell
        let picture = viewModel?.pictures.value?[indexPath.row]
        cell.updateCell(withImageURL: picture?.imageURL)
        return cell
    }
    
}

extension PictureSearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * 4
        let availableWidth = imageCollectionView.frame.width - paddingSpace
        let widthPerItem  = availableWidth/3
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
}

extension PictureSearchViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if ((imageCollectionView.contentOffset.y + imageCollectionView.frame.size.height) >= imageCollectionView.contentSize.height && isLoading == false){
            isLoading = true
            viewModel?.queryString = queryTextField.text ?? ""
        }
    }
}

extension PictureSearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        isLoading = true
        viewModel?.queryString = queryTextField.text ?? ""
        return true
    }
}
