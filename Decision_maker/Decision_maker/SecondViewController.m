//
//  SecondViewController.c
//  Decision_maker
//
//  Created by MIngu Ji on 2014-07-06.
//  Copyright (c) 2014 MIngu Ji. All rights reserved.
//

#import "SecondViewController.h"
#import "ViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize _answers;
@synthesize answers;
@synthesize temp_;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //pass _answers value from ViewController.m to answers label
    self.answers.text = self._answers;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done
{
    [self performSegueWithIdentifier:@"Return" sender:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (([[segue identifier] isEqualToString:@"Return"]))
    {
        ViewController *view = (ViewController *)segue.destinationViewController;
        view._temp_ = temp_;
    }
}

@end
