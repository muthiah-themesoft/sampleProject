//
//  WOForgotPasswordViewController.m
//  WOKE
//
//  Created by mac on 11/23/15.
//  Copyright © 2015 Themesoft. All rights reserved.
//

#import "WOForgotPasswordViewController.h"

@interface WOForgotPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;

@end

@implementation WOForgotPasswordViewController
- (IBAction)forgotPassword:(UIButton *)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.resetButton.layer.borderColor =[UIColor blackColor].CGColor;

    // Do any additional setup after loading the view.
}
- (IBAction)cancelButonAction:(UIButton *)sender {
   
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
