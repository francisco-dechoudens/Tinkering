//
//  ViewController.m
//  SearchAutoCompleteDemo
//
//  Created by Frankie on 7/10/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *autocompleteTableView;

@end

@implementation ViewController{
    NSArray* autocompleteList;
    NSMutableArray* placeList;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    autocompleteList = [NSMutableArray new];
    placeList = [[NSMutableArray alloc] initWithArray:@[@"Fred",@"Frankie",@"Bob",@"Simon",@"Francsu",@"Men",@"Arnold",@"Keneppo"]];
    self.searchBar.delegate = self;
    [self setAutoComplete];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
        self.autocompleteTableView.hidden = NO;
        
        NSString *substring = [NSString stringWithString:searchBar.text];
        substring = [substring
                     stringByReplacingCharactersInRange:range withString:text];
        [self searchAutocompleteEntriesWithSubstring:substring];
        return YES;
}

-(void)setAutoComplete{
    
    self.autocompleteTableView.delegate = self;
    self.autocompleteTableView.dataSource = self;
    self.autocompleteTableView.scrollEnabled = YES;
    self.autocompleteTableView.hidden = YES;

}

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
    
    NSString *predicateFormat = [NSString stringWithFormat:@"SELF contains[cd] '%@'",substring];
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:predicateFormat];
    autocompleteList = [placeList filteredArrayUsingPredicate:resultPredicate];
    
    [self.autocompleteTableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return autocompleteList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    UILabel *label = (UILabel*)[cell viewWithTag:100];
    
    label.text = autocompleteList[indexPath.row];

    [cell addSubview:label];
    
    return cell;
}

@end
