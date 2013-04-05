//
//  ViewController.m
//  KITableViewSample
//
//  Created by Katsunobu Ishida on 2013/04/05.
//  Copyright (c) 2013 Katsunobu Ishida. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.doneButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonDidTouch:)];
    self.editingButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editingButtonDidTouch:)];
    self.navigationBar.topItem.rightBarButtonItem = self.editingButtonItem;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
	if (editing == self.editing) return;
	
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
    self.navigationBar.topItem.rightBarButtonItem = editing ? self.doneButtonItem : self.editingButtonItem;
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = @"test";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.isEditing ? UITableViewCellEditingStyleInsert : UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete)
    {
		NSLog(@"Delete cell: %@", indexPath);
	}
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
		NSLog(@"Insert cell: %@", indexPath);
	}
}

- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self setEditing:YES animated:YES];
}

- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self setEditing:NO animated:YES];
}

#pragma mark - Action

- (IBAction)editingButtonDidTouch:(id)sender
{
    [self setEditing:!self.editing animated:YES];
}

- (IBAction)doneButtonDidTouch:(id)sender
{
    [self setEditing:!self.editing animated:YES];
}

@end
