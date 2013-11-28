//
//  CHListViewController.m
//  TextKitDynamicTypes
//
//  Created by David Bonnet on 28/11/2013.
//  Copyright (c) 2013 David Bonnet. All rights reserved.
//

#import "CHListViewController.h"
#import "CHDetailsViewController.h"

@interface CHListViewController ()

@property (nonatomic, strong) NSArray *content;

@end

@implementation CHListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Dynamic Text Types";
    
    NSString *contentPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Content" ofType:@"plist"];
    self.content = [NSArray arrayWithContentsOfFile:contentPath];
    
    [[NSNotificationCenter defaultCenter] addObserver:self.tableView
                                             selector:@selector(reloadData)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.content count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.detailTextLabel.numberOfLines = 3;
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    
    cell.textLabel.font         = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    cell.detailTextLabel.font   = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    
    cell.textLabel.text         = self.content[indexPath.row][@"title"];
    cell.detailTextLabel.text   = self.content[indexPath.row][@"content"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CHDetailsViewController *details = [[CHDetailsViewController alloc] initWithTitle:self.content[indexPath.row][@"title"]
                                                                              content:self.content[indexPath.row][@"content"]];
    [self.navigationController pushViewController:details animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.f;
}

@end
