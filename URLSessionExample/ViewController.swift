//
//  ViewController.swift
//  URLSessionExample
//
//  Created by Gabriel Lievano on 11/3/16.
//  Copyright © 2016 Juan Gabriel Lievano. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
    UICollectionViewDelegate, UICollectionViewDataSource {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  // An array with paths of images to download. We will cycle over these to be able to download
  // infinite images on this example app.
  // NOTICE: Some of these paths are "http" and not "https". Apple by default forbids requesting
  // to unsecure protocols. Because most websites out there are still not secure (http) then we have
  // to allow this for our app. To do so you have to add this to your Info.plist:
  //     App Transport Security Settings +    (Add an item, this is a dictionary)
  //         Allow Arbitrary Loads       BOOL (Set to YES)
  let imagePaths = [
    "http://www.sandiego-tech.com/wp-content/uploads/2016/09/tech3.jpg",
    "http://internet-us.com/upload/sources/69251443068304.jpg",
    "http://cdn.thedailybeast.com/content/dailybeast/articles/2016/04/23/welcome-to-the-devolution-the-high-tech-world-is-making-us-weak-and-weird/jcr:content/image.crop.800.500.jpg/48712578.cached.jpg",
    "http://sm.pcmag.com/pcmag_uk/photo/default/tech-blog_g3b5.jpg",
    "https://www.thetech.org/sites/default/files/styles/home_happening_1x/public/the-tech-awards.png?itok=ja_orBjm"
  ]
  
  // This variable keeps track of which image path to download next.
  var currentPath = 0

  // This method is linked to a button in the storyboard. That way we can control how fast we
  // download images.
  @IBAction func downloadImage(_ sender: UIBarButtonItem) {
    ImageLoader.shared.downloadImage(path: imagePaths[currentPath]) {
      // This piece of code here runs on the main queue (UI thread). This is handled automatically
      // by the ImageLoader. See code.
      self.collectionView.reloadData()
    }
    // Cycles currentPath from 0 to the number of image paths in imagePaths and back to 0.
    currentPath = (currentPath + 1) % imagePaths.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return ImageLoader.shared.size
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExampleCell", for: indexPath) as! ExampleCollectionViewCell
    cell.thumbImage.image = ImageLoader.shared.images[indexPath.row]
    return cell
  }
  
}

