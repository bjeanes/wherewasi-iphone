//
//  LandingDatasource.m
//  wherewasi
//
//  Created by Anthony Mittaz on 19/03/10.
//  Copyright 2010 Mogeneration. All rights reserved.
//

#import "LandingDatasource.h"
#import "LandingServices.h"

@implementation LandingDatasource

#pragma mark -
#pragma mark Content

- (NSMutableArray *)content
{
	if (!_content) {
		_content = [[NSMutableArray alloc]initWithCapacity:0];
		[_content addObjectsFromArray:[LandingServices sharedLandingServices].landings];
	}
	return _content;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
#define LandingCellIdentifier @"LandingCellIdentifier"
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LandingCellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:LandingCellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
	
	CellObject *cellObject = (CellObject *)[self objectForIndexPath:indexPath forTableView:tableView];
	
	cell.textLabel.text = cellObject.label1;
	cell.detailTextLabel.text = cellObject.label2;
	
    return cell;
}


@end
