//
//  SecondViewController.h
//  Decision_maker
//
//  Created by MIngu Ji on 2014-07-06.
//  Copyright (c) 2014 MIngu Ji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController
{

}

//Declaration of actions(routines)

- (IBAction)done;
@property (nonatomic, copy) NSString *_answers;
@property (nonatomic, copy) NSString *temp_;
@property IBOutlet UILabel *answers;
@end
