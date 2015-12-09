//
//  LoginViewController.m
//  WOKE
//
//  Created by mac on 9/29/15.
//  Copyright © 2015 Themesoft. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTxt;
@property (weak, nonatomic) IBOutlet UITextField *passWordTxt;
@property (strong, nonatomic)  UITextField *currentTextfield;
@property (weak, nonatomic) IBOutlet UIButton *forgotPasswordButton;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *createAccountButton;
- (IBAction)loginButtonClicked:(UIButton *)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.signInButton.layer.borderColor =[UIColor blackColor].CGColor;
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor lightGrayColor].CGColor;
    border.frame = CGRectMake(0, _userNameTxt.frame.size.height - borderWidth, _userNameTxt.frame.size.width, _userNameTxt.frame.size.height);
    border.borderWidth = borderWidth;
    [_userNameTxt.layer addSublayer:border];
    _userNameTxt.layer.masksToBounds = YES;
    
    
    CALayer *border1 = [CALayer layer];
    CGFloat borderWidth1 = 1;
    border1.borderColor = [UIColor lightGrayColor].CGColor;
    border1.frame = CGRectMake(0, _passWordTxt.frame.size.height - borderWidth1, _passWordTxt.frame.size.width, _passWordTxt.frame.size.height);
    border1.borderWidth = borderWidth;
    [_passWordTxt.layer addSublayer:border1];
    _passWordTxt.layer.masksToBounds = YES;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#define kOFFSET_FOR_KEYBOARD 100.0

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES withTextfield:self.currentTextfield];
    }
    else if (self.view.frame.origin.y < 0)
    {
//        [self setViewMovedUp:NO withTextfield:self.currentTextfield];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES withTextfield:self.currentTextfield];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO withTextfield:self.currentTextfield];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    self.currentTextfield =sender;
    if ([sender isEqual:self.passWordTxt]||[sender isEqual:self.userNameTxt])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES withTextfield:self.currentTextfield];
        }
    }

        
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"textFieldShouldReturn:");
    if (textField.tag == 100) {
        UITextField *passwordTextField = (UITextField *)[self.view viewWithTag:101];
        [passwordTextField becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    return YES;
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp withTextfield:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginButtonClicked:(UIButton *)sender {
    

//    if(![MGUtilities hasInternetConnection]) {
//        UIColor* color = [THEME_MAIN_COLOR colorWithAlphaComponent:0.70];
//        [MGUtilities showStatusNotifier:LOCALIZED(@"Network Unavailable while connecting.")
//                              textColor:[UIColor whiteColor]
//                         viewController:self
//                               duration:0.5f
//                                bgColor:color
//                                    atY:64];
//        return;
//    }
//    
    NSString* username = [_userNameTxt text];
    NSString* password = [_passWordTxt text];
    
    if(username.length == 0 || password.length == 0) {
        
//        [MGUtilities showAlertTitle:LOCALIZED(@"Login Error")
//                            message:LOCALIZED(@"Username and Password field are required.")];
        return;
    }
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    
    NSURL *url = [NSURL URLWithString:@"http://www.creativelabinteractive.com/woke/api/index.php?route=account/login"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            API_KEY,@"client_key",
                            _userNameTxt.text, @"username",
                            _passWordTxt.text, @"password",
                            @"fffff",@"device_id",
                            
                            nil];
    
    [httpClient postPath:@"" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions
                                                               error:&error];
        
        NSLog(@"LOGIN_SYNC = %@", json);
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];

        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
        
    }];
}
@end
