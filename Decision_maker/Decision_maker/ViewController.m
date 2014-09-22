//
//  ViewController.m
//  Decision_maker
//
//  Created by MIngu Ji on 2014-07-06.
//  Copyright (c) 2014 MIngu Ji. All rights reserved.
//

#import "ViewController.h"
#import "GLKitViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize _temp_;
//Setup before the answer
-(IBAction)next
{
    temp = _temp_;
    if (self.restorationIdentifier == @"answer_btn") {
        [question resignFirstResponder];
    }
    question_content = question.text;
    if(question_start == nil)
    {
        question_start = [NSArray arrayWithObjects: @"How", @"What", @"Why", @"Who", @"When", @"Where", @"Which",nil];
        warning = [NSArray arrayWithObjects: @"kill", @"die", @"corpse", @"suicide", @"death",nil];
        decisions = [NSArray arrayWithObjects: @"Of Course!", @"Are you kidding?", @"Follow your mind", @"Nope", @"Yes",nil];
    }
	
}

//To dismiss keyboard when background is touched
- (IBAction)backgroundTouch:(id)sender {
    [question resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

//To pass value forward using seague's
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (([[segue identifier] isEqualToString:@"next"]) || ([[segue identifier] isEqualToString:@"return"]))
    {
        GLKitViewController *glkitview = (GLKitViewController *)segue.destinationViewController;
        //Check if the question is a repeated question
        if ([question_content isEqualToString:temp]) {
            glkitview._answers = @"You already asked this question :p";
            return;
        }
        //Check if the question ends with "?"
        if (![question_content hasSuffix:@"?"]) {
            glkitview._answers = @"A question mark is needed :)";
            return;
        }
        else {
            for(int i = 0; i<[question_start count]; i++)//count the length of question_string
            {
                if([[question_content lowercaseString] rangeOfString: [[question_start objectAtIndex:i] lowercaseString]].location != NSNotFound)
                {
                    //if the question contains any word in question_start array
                    glkitview._answers = @"I'm a decision maker, not a prophet!";
                    return;
                }
            }
            for(int i = 0; i<[warning count]; i++)//count the length of question_string
            {
                if ([[question_content lowercaseString] rangeOfString: [[warning objectAtIndex:i] lowercaseString]].location != NSNotFound)
                {
                    //if the question contains any word in warning array
                    glkitview._answers = @"Oh Please dont be ridiculouse!";
                    return;
                }
            }
        }
        
        glkitview._answers = [decisions objectAtIndex:(arc4random() % [decisions count])];
        temp = question_content;
        glkitview._temp = temp;
    }
}
@end
