//
//  ViewController.h
//  Decision_maker
//
//  Created by MIngu Ji on 2014-07-06.
//  Copyright (c) 2014 MIngu Ji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
   IBOutlet UITextField *question;
    id<UITextFieldDelegate> delegate;
    NSString *question_content;
    NSArray *question_start;
    NSArray *warning;
    NSArray *decisions;
    NSString *temp;
}
//Declaration of actions(routines)
-(IBAction)next;
-(IBAction)backgroundTouch:(id)sender;
@property (nonatomic, copy) NSString *_temp_;
@property(nonatomic, assign) id<UITextFieldDelegate> delegate;

@end
