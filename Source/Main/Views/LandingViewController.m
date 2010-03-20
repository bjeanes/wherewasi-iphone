//
//  LandingViewController.m
//  wherewasi
//
//  Created by Anthony Mittaz on 19/03/10.
//  Copyright 2010 Mogeneration. All rights reserved.
//

#import "LandingViewController.h"
#import "LandingDatasource.h"
#import "LocationPointsViewController.h"

@implementation LandingViewController

#pragma mark -
#pragma mark Initialisation

@synthesize accuracy=_accuracy;

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
	
	self.accuracy = 0.0;
	
	if ([AppDelegate sharedAppDelegate].locationGetter.locationManager.locationServicesEnabled) {
		// Try to see when location getter got a fix
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(locationDidFix:) 
													 name:GPSLocationDidFix
												   object:nil];
	}
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(refreshContent:) 
												 name:LoginShouldReloadContentNotification
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(refreshContent:) 
												 name:DidPostLocationPoint
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(refreshContent:) 
												 name:NSManagedObjectContextDidSaveNotification
											   object:nil];
	
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
    
	CellObject *object = (CellObject *)[self.dataSource objectForIndexPath:indexPath forTableView:tableView];
	
	if ([object.label1 isEqualToString:@"Generate Token"]) {
		[[LoginServices sharedLoginServices]apiToken];
	} else if ([object.label1 isEqualToString:@"Create Point"]) {
		LocationPointsViewController *controller = [[[LocationPointsViewController alloc]initWithNibName:@"LocationPointsView" 
																								  bundle:nil]autorelease];
		UINavigationController *navController = [[[UINavigationController alloc]initWithRootViewController:controller]autorelease];
		[self.navigationController presentModalViewController:navController animated:TRUE];
	} else if ([object.label1 isEqualToString:@"Sync"]) {
		NSArray *points = [LocationPointsServices sharedLocationPointsServices].uncachedLocationPoints;
		[[LocationPointsServices sharedLocationPointsServices]postLocationPoints:points];
	}
	
	[tableView deselectRowAtIndexPath:indexPath animated:TRUE];
}

- (void)locationDidFix:(id)sender
{
	if ([AppDelegate sharedAppDelegate].currentLocation.horizontalAccuracy != self.accuracy) {
		[self refreshContent:sender];
	}
}

- (void)refreshContent:(id)sender
{
	[self.dataSource resetContent];
	[self.tableView reloadData];
}

- (void)dealloc {
	
	[[NSNotificationCenter defaultCenter]removeObserver:self];
	
    [super dealloc];
}

@end
