//
//  ViewController.m
//  Lesoon35 UITableViewSearch
//
//  Created by Nik on 25.08.15.
//  Copyright (c) 2015 Nik. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Random_String.h"
#import "NSSection.h"


@interface ViewController ()

@property (strong,nonatomic) NSArray* namesArray;

@property (strong,nonatomic) NSArray* sectionsArray;

@property (strong,nonatomic) NSOperation* currentOperation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSMutableArray* array = [NSMutableArray array];
    
    
    for (int i =0; i < 100;i++) {
        [array addObject:[[NSString randomAlphanumericStringWithLength:10]capitalizedString ]];
    }
    
    NSSortDescriptor* sortDescroitor = [[NSSortDescriptor alloc]initWithKey:@"self" ascending:YES];
    
    [array sortUsingDescriptors:@[sortDescroitor]];
    
    self.namesArray = array;
  //  self.sectionsArray = [self generateSectionsFromArray:self.namesArray withFilter:self.searchBar.text];
  //  [self.tableView reloadData];
  
    [self generateSectionsInBackgroundFromArray:self.namesArray withFilter:self.searchBar.text];
    
}

- (void) generateSectionsInBackgroundFromArray:(NSArray*) array withFilter:(NSString* ) filterString {
    
    [self.currentOperation cancel];
    
    __weak ViewController *wealSelf = self;
    
    self.currentOperation = [NSBlockOperation blockOperationWithBlock:^{

        NSArray* sectionArray = [self generateSectionsFromArray:array withFilter:filterString];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            wealSelf.sectionsArray = sectionArray;
            [wealSelf.tableView reloadData];
        });
    
    }];
    [self.currentOperation start];
    
}

- (NSArray*) generateSectionsFromArray:(NSArray*) array withFilter:(NSString* ) filterString{
    
    NSMutableArray* sectionsArray = [NSMutableArray array];
    
    
    NSString* currentLetter = nil;
    for (NSString* string in array) {
        
        
        if  ([filterString length] > 0 && [string rangeOfString:filterString ].location == NSNotFound ) {
            continue;
        }
        
        
        NSString* firstLetter = [string substringToIndex:1];
        
        NSSection* section = nil;
        
        if (![currentLetter isEqualToString:firstLetter]) {
            section = [[NSSection alloc]init];
            section.sectionName = firstLetter;
            section.itemsArray = [NSMutableArray array];
            currentLetter  = firstLetter;
            [sectionsArray addObject:section];
        }else{
            
            section = [sectionsArray lastObject];
        }
        
        [section.itemsArray addObject:string];
    }
    
    return sectionsArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma  mark - Data Source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{

    NSSection* sec = [self.sectionsArray objectAtIndex:section];
    
    
    return [sec.itemsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* identifier  =@"cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    NSSection* section = [self.sectionsArray objectAtIndex:indexPath.section];

    NSString* name = [section.itemsArray objectAtIndex:indexPath.row];
    
    
    cell.textLabel.text  = name;
    
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 
    return [self.sectionsArray count];
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    return [[self.sectionsArray objectAtIndex:section]sectionName];

}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    
    NSMutableArray* array  =[NSMutableArray array];
    
    for (NSSection* section in self.sectionsArray) {
        [array addObject:section.sectionName];
    }
    
    return array;
    
}
#pragma  mark - SearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
 
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:YES animated:YES];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
  
    NSLog(@"texDidChange: %@",searchText);
    
   // self.sectionsArray = [self generateSectionsFromArray:self.namesArray withFilter:self.searchBar.text];
    //[self.tableView reloadData];
    [self generateSectionsInBackgroundFromArray:self.namesArray withFilter:self.searchBar.text];

    
}
@end
