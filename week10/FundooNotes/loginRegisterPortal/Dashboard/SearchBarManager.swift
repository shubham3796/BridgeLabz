import UIKit

//   SEARCH BAR FUNCTIONALITIES
extension DashboardController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //        searchActive = true
        let arrayOfNotes = GetData.localArrayOfNotes
        
        if searchText.count != 0{
            filteredArrayOfNotes = arrayOfNotes.filter({ index -> Bool in
                (index.oneTitle! + index.note).lowercased().contains(searchText.lowercased())
            })
        }
        else {
            filteredArrayOfNotes = arrayOfNotes
        }
        myCollectionView.reloadData()
        //viewDidLoad()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.dismiss(animated: true, completion: nil)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
        myCollectionView.reloadData()
    }
    
}

