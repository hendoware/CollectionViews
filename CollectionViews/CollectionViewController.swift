import UIKit

class CollectionViewController: UICollectionViewController {

    let reuseIdentifier = "cell"
    let headerReuseIdentifier = "header"
    
    override func viewDidLoad() {
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        
        let headernib = UINib(nibName: "CollectionReusableHeaderView", bundle: nil)
        collectionView.register(headernib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return ColorHelper.shared.sectionCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ColorHelper.shared.rowsFor(section: section)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionViewCell else {fatalError("Inconsistent view state")}
        cell.nameLabel.text = ColorHelper.shared.nameFor(indexPath: indexPath)
        cell.swatch.backgroundColor = ColorHelper.shared.colorFor(indexPath: indexPath)
        cell.layer.borderWidth = 1
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {fatalError("Unable to retrieve layout")}
        let amount: CGFloat = 32
        layout.sectionInset = UIEdgeInsets(top: amount, left: amount, bottom: amount, right: amount)
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.headerReferenceSize = CGSize(width: collectionView.bounds.width, height: 32)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            fatalError("Failed header")}
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath) as? CollectionReusableHeaderView else {
            fatalError("Bad Header")}
        
        header.nameLabel.text = ColorHelper.shared.keyFor(indexPath: indexPath)
        
        return  header
    }
}
