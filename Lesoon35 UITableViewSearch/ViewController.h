//
//  ViewController.h
//  Lesoon35 UITableViewSearch
//
//  Created by Nik on 25.08.15.
//  Copyright (c) 2015 Nik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController <UISearchBarDelegate>

@property(weak,nonatomic) IBOutlet UISearchBar* searchBar;

@end

