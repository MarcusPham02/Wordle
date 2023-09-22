//
//  KeyboardViewController.swift
//  Wordle
//
//  Created by Mari Batilando on 2/12/23.
//

import UIKit

class KeyboardController: NSObject,
                          UICollectionViewDataSource,
                          UICollectionViewDelegate,
                          UICollectionViewDelegateFlowLayout {

  private let keyboardRows: [[String]] = [
    ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
    ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
    ["Z", "X", "C", "V", "B", "N", "M", DELETE_KEY]
  ]
  var didSelectString: ((String) -> Void)?

  init(collectionView: UICollectionView) {
    super.init()
    collectionView.delegate = self
    collectionView.dataSource = self
  }

  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
      // Return the correct number of items in a section
      guard section >= 0 && section < keyboardRows.count else {
          return 0
      }
      return keyboardRows[section].count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeyboardCell",
                                                  for: indexPath) as! KeyboardCell
    
    let item = keyboardRows[indexPath.section][indexPath.row]
    
    // Configure the cell with the current item
    cell.configure(with: item)
    
    // Pass the didSelectString closure to the KeyboardCell's corresponding property
      cell.didSelectString = { [weak self] (item: String) -> Void in
          guard let self = self else { return }
          // Call the didSelectString closure with the selected string (item)
          self.didSelectString?(item)
      }
 // Explicitly specify the closure type
         
         return cell
  }

  // MARK: - Private Methods
  func numItems(in row: Int) -> Int {
    return keyboardRows[row].count
  }
}

