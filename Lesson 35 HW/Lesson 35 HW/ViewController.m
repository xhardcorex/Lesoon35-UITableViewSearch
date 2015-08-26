//
//  ViewController.m
//  Lesson 35 HW
//
//  Created by Nik on 25.08.15.
//  Copyright (c) 2015 Nik. All rights reserved.
//

#import "ViewController.h"
#import "NSStudent.h"

@interface ViewController ()

@property (strong,nonatomic) NSMutableArray* arrayOfStudents;

@property (strong,nonatomic) NSMutableArray* sortedByMonthStudents;


@property (strong,nonatomic) NSArray* arrayOfMonthes;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.arrayOfStudents = [NSMutableArray array];
    
    NSMutableArray* array = [NSMutableArray array];
    
    for (int i =0 ;i < (arc4random()%10000 - 10) +10;  i++) {
        
        NSStudent* student = [[NSStudent alloc]init];
        
        [array addObject:student];
        
    }
    
    self.arrayOfStudents = array;
    [self createArrayOfMonthes];
   // [self sortedByMonthStudents];

    self.sortedByMonthStudents = [NSMutableArray array];
    
    [self sortStudentByMonth];


}



#pragma mark - My methods

- (void) sortStudentByMonth{
    
    self.sortedByMonthStudents = [NSMutableArray array];
    
    NSInteger month = 1;
    
    
    NSMutableArray* tempArray = [NSMutableArray array];
    
    
    
    for (int i = 0 ; i < [self.arrayOfStudents count] ; i++) {
        
        NSStudent* student = [self.arrayOfStudents objectAtIndex:i];
        
        if (student.month == month) {
            [tempArray addObject:student];
        }
        
        if (i == [self.arrayOfStudents count] - 1) {
            i = 0;
            [self.sortedByMonthStudents addObject:tempArray];
           // NSLog(@"COunt temp array : %d",[tempArray count]);
            //NSLog(@"COunt sortbymonth : %d",[self.sortedByMonthStudents count]);
            
           
            
            NSSortDescriptor *surname = [NSSortDescriptor
                                         sortDescriptorWithKey:@"surname" ascending:YES];
            
            NSSortDescriptor *name = [NSSortDescriptor
                                      sortDescriptorWithKey:@"name" ascending:YES];
            NSSortDescriptor *dateOfBirth = [NSSortDescriptor
                                      sortDescriptorWithKey:@"dateOfBirth" ascending:YES];
            
            [tempArray sortUsingDescriptors:[NSArray arrayWithObjects:surname,name,dateOfBirth, nil]];

            
            tempArray = [NSMutableArray array];
            month++;
            if (month==13) {
                break;
            }
        }
        
    }
    
    
}
- (void) createArrayOfMonthes{
    
    self.arrayOfMonthes = [[NSArray alloc]initWithObjects:@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"De", nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark - Data Source

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    
    NSMutableArray* array  =[NSMutableArray array];
    
    for (NSString* section in self.arrayOfMonthes) {
        [array addObject:section];
    }
    
    return array;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
 
    NSMutableArray* tempArray = [self.sortedByMonthStudents objectAtIndex:section];
    
    return  [tempArray count];
    
    }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* identifier  =@"cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
  
    NSMutableArray* tempArray = [self.sortedByMonthStudents objectAtIndex:indexPath.section];
    
    NSStudent* student  = [tempArray objectAtIndex:indexPath.row];
    
     NSLog(@"%@ %@",student.surname,student.name);
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",student.surname,student.name];
    cell.detailTextLabel.text = [student showDateOfBirth:student.dateOfBirth];
    
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 
    return [self.arrayOfMonthes count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    
    NSString* month = [self.arrayOfMonthes objectAtIndex:section];
    return month;
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
    
   // NSLog(@"texDidChange: %@",searchText);
    
    // self.sectionsArray = [self generateSectionsFromArray:self.namesArray withFilter:self.searchBar.text];
    //[self.tableView reloadData];
   // [self generateSectionsInBackgroundFromArray:self.namesArray withFilter:self.searchBar.text];
    
    
}

@end
