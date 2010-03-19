//
//  LandingViewController.m
//  wherewasi
//
//  Created by Anthony Mittaz on 19/03/10.
//  Copyright 2010 Mogeneration. All rights reserved.
//

#import "LandingViewController.h"
#import "LandingDatasource.h"

@implementation LandingViewController

#pragma mark -
#pragma mark Initialisation

- (void)setupCustomInitialisation
{
	[super setupCustomInitialisation];
	
	if (!self.managedObjectContext) {
		self.managedObjectContext = [AppDelegate sharedAppDelegate].managedObjectContext;
	}
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Choose action";
}

#pragma mark -
#pragma mark Setup

- (void)setupNavigationBar
{
	[super setupNavigationBar];
	
	UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
	self.navigationItem.backBarButtonItem = backBarButtonItem;
	[backBarButtonItem release];
}

- (void)setupDataSource
{
	[super setupDataSource];
	
	self.tableView.rowHeight = 44.0;
	
	self.dataSource = [[[LandingDatasource alloc]init]autorelease];
	self.dataSource.object = self.object;
	self.tableView.dataSource = self.dataSource;
}

#pragma mark -
#pragma mark tableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	NSString *category = [self.dataSource objectForIndexPath:indexPath forTableView:tableView];
	
	if ([category isEqualToString:@"Create Point"]) {
		
	}
	[tableView deselectRowAtIndexPath:indexPath animated:TRUE];
}

- (void)dealloc {
	
    [super dealloc];
}

@end
