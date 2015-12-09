//
//  ProfileViewController.m
//  WOKE
//
//  Created by mac on 9/30/15.
//  Copyright © 2015 Themesoft. All rights reserved.
//

#import "WOProfileViewController.h"
#import "WOContactTableViewCell.h"
#import "AppDelegate.h"
@interface WOProfileViewController ()<UITextFieldDelegate, UITextViewDelegate>
{
    NSArray *contactLabelArry;
    NSArray *contactImageArry;

}
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UIButton *profileImage;

@property (weak, nonatomic) IBOutlet UILabel *profileName;
@property (weak, nonatomic) IBOutlet UILabel *profileAddress;
@property (weak, nonatomic) IBOutlet UILabel *lastSeen;
@property (weak, nonatomic) IBOutlet UILabel *statusMessage;
@property (weak, nonatomic) IBOutlet UITableView *profileTableView;

- (IBAction)logoutAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (strong, nonatomic)  UIButton *profileImageButton;
@property (strong, nonatomic)  AppDelegate* appdelegateObj;
- (IBAction)cancelAction:(id)sender;
- (IBAction)doneAction:(id)sender;

@end

@implementation WOProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _appdelegateObj = (AppDelegate*)[[UIApplication sharedApplication]delegate];

    self.takeController = [[FDTakeController alloc] init];
    self.takeController.delegate = (id)self;
    self.logoutButton.layer.borderColor =[UIColor blackColor].CGColor;

    self.profileImageView.layer.borderColor =[UIColor whiteColor].CGColor;
    self.profileImageView.image =[UIImage imageNamed:@"email1"];
    self.profileTableView.backgroundColor =[UIColor clearColor];
    self.profileTableView.separatorColor= [UIColor clearColor];
    contactLabelArry =[NSArray arrayWithObjects:@"mobile",@"Mobile Phone",@"Email Address",@"Office Address",@"Home Address" ,nil];
    contactImageArry =[NSArray arrayWithObjects:@"WOK_MOBILE_ICON",@"WOK_PHONE_ICON",@"WOK_EMAIL_ICON",@"WOK_OFFICE_ICON",@"WOK_HOUSE_ICON", nil];
    self.profileTableView.allowsSelection = NO;
    self.statusMessage.text =@"Hey I am at Grocery";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];


//self.profileTableView.tableFooterView = [UIView new];
   
    // Do any additional setup after loading the view.
}
- (IBAction)addProfile:(UIButton *)sender {
    _profileImageButton = sender;
    [self.takeController takePhotoOrChooseFromLibrary];

}

- (void)takeController:(FDTakeController *)controller gotPhoto:(UIImage *)photo withInfo:(NSDictionary *)info
{
    [_profileImageButton setBackgroundImage:photo forState:UIControlStateNormal];
    _profileImageButton.layer.cornerRadius = 30;
   _profileImageButton.layer.masksToBounds = YES;
    self.appdelegateObj.userObj.profileImage =photo;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Create your first status update!"]) {
        textView.text = @"";
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Create your first status update!";
    }
    [textView resignFirstResponder];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0) {
        return [contactLabelArry count];
    }
    return 5;    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section==0) {
        if ((indexPath.row==1 || indexPath.row==2)) {
            static NSString *MyIdentifier = @"contactCell2";
            
            WOContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
            
            if (cell == nil)
            {
                cell = [[WOContactTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:MyIdentifier];
            }
            [cell.contactTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
            cell.backgroundColor =[UIColor clearColor];
            cell.contactTitle.text =[contactLabelArry objectAtIndex:indexPath.row];
            cell.contactIcon.image = [UIImage imageNamed:[contactImageArry objectAtIndex:indexPath.row]];
            if (indexPath.row == 0)                 cell.nameTextField.text = _appdelegateObj.userObj.fullName;

            if (indexPath.row == 1)
            {
                [cell.contactTextField setKeyboardType:UIKeyboardTypeNumberPad];
                cell.contactTextField.text = _appdelegateObj.userObj.phoneNo;
            }

            if (indexPath.row == 2)                 cell.contactTextField.text = _appdelegateObj.userObj.userEmail;

            if (indexPath.row == 3)                 cell.contactTextField.text = _appdelegateObj.userObj.officeAddress;

            if (indexPath.row == 4)                 cell.contactTextField.text = _appdelegateObj.userObj.homeAddress;
            return cell;
        }
     
        else if(indexPath.row==4||indexPath.row == 3){
            static NSString *MyIdentifier = @"addressCell";

            WOContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];

            if (cell == nil)
            {
                cell = [[WOContactTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                     reuseIdentifier:MyIdentifier];
            }
            cell.contactTitle.text =[contactLabelArry objectAtIndex:indexPath.row];
            cell.contactIcon.image = [UIImage imageNamed:[contactImageArry objectAtIndex:indexPath.row]];

            cell.backgroundColor =[UIColor clearColor];
            return cell;
        }
        else{
            static NSString *MyIdentifier = @"contactCell";
            
            WOContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
            
            if (cell == nil)
            {
                cell = [[WOContactTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:MyIdentifier];
            }
            [cell.nameTextField setClearButtonMode:UITextFieldViewModeWhileEditing];

            cell.backgroundColor =[UIColor clearColor];
            cell.contactTitle.text =[contactLabelArry objectAtIndex:indexPath.row];
            cell.contactIcon.image = [UIImage imageNamed:[contactImageArry objectAtIndex:indexPath.row]];
            if (self.appdelegateObj.userObj.profileImage!=nil) {
                [cell.profileImage setBackgroundImage:self.appdelegateObj.userObj.profileImage forState:UIControlStateNormal];
                cell.profileImage.layer.cornerRadius = 30;
                cell.profileImage.layer.masksToBounds = YES;
            }
            cell.phoneNoLabel.text =@"000-000-000";
     cell.statusMessage.text=self.appdelegateObj.userObj.statusMessage;
       cell.nameTextField.text = _appdelegateObj.userObj.fullName;
            return cell;
        }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return 50.0;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *HeaderCellIdentifier = @"emergencyHeader";
    
    WOContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HeaderCellIdentifier];
    if (cell == nil) {
        cell = [[WOContactTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeaderCellIdentifier];
    }
    cell.backgroundColor =[UIColor clearColor];
    
    // Configure the cell title etc
  
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0)
            return 192;
        else if (indexPath.row == 3)
            return 117;
        else if (indexPath.row == 4)
            return 117;
        else
            return 90;
    }
    if (indexPath.section ==1 ) {
    return 73;
    }
    return 238;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL result = YES;
    
    
    
  
    NSIndexPath *indexPath = [self.profileTableView indexPathForCell:(WOContactTableViewCell*)[[textField superview] superview]]; // this should return you your current indexPath
    
    // From here on you can (switch) your indexPath.section or indexPath.row
    // as appropriate to get the textValue and assign it to a variable, for instance:
    if (indexPath.section == 0 && indexPath.row==1) {
    if (string.length != 0) {
        NSMutableString *text = [NSMutableString stringWithString:[[textField.text componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""]];
        [text insertString:@"(" atIndex:0];
        
        if (text.length > 3)
            [text insertString:@") " atIndex:4];
        
        if (text.length > 8)
            [text insertString:@"-" atIndex:9];
        
        if (text.length > 13) {
            text = [NSMutableString stringWithString:[text substringToIndex:14]];
            result = NO;
        }
        textField.text = text;
    }
    
    }
    return result;
}
- (void) textFieldDidEndEditing:(UITextField *)textField {

NSIndexPath *indexPath = [self.profileTableView indexPathForCell:(WOContactTableViewCell*)[[textField superview] superview]]; // this should return you your current indexPath

// From here on you can (switch) your indexPath.section or indexPath.row
// as appropriate to get the textValue and assign it to a variable, for instance:
if (indexPath.section == 0) {
    if (indexPath.row == 0) self.appdelegateObj.userObj.fullName = textField.text;
    if (indexPath.row == 1) self.appdelegateObj.userObj.phoneNo = textField.text;
    if (indexPath.row == 2) self.appdelegateObj.userObj.userEmail = textField.text;
    if (indexPath.row == 3) self.appdelegateObj.userObj.officeAddress = textField.text;
    if (indexPath.row == 4) self.appdelegateObj.userObj.homeAddress  = textField.text;
}
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)logoutAction:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Keyboard Notifications

- (void)keyboardWillShow:(NSNotification *)notification;
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *keyboardBoundsValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyboardHeight = [keyboardBoundsValue CGRectValue].size.height;

    CGFloat duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSInteger animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    UIEdgeInsets insets = [[self profileTableView] contentInset];
    [UIView animateWithDuration:duration delay:0. options:animationCurve animations:^{
        [[self profileTableView] setContentInset:UIEdgeInsetsMake(insets.top, insets.left, keyboardHeight, insets.right)];
        [[self view] layoutIfNeeded];
    } completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)notification;
{
    NSDictionary *userInfo = [notification userInfo];
    CGFloat duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSInteger animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    UIEdgeInsets insets = [[self profileTableView] contentInset];
    [UIView animateWithDuration:duration delay:0. options:animationCurve animations:^{
        [[self profileTableView] setContentInset:UIEdgeInsetsMake(insets.top, insets.left, 0., insets.right)];
        [[self view] layoutIfNeeded];
    } completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    // Dismisses the keyboard when the "Done" button is clicked

    [textField resignFirstResponder];

    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    NSIndexPath *indexPath = [self.profileTableView indexPathForCell:(WOContactTableViewCell*)[[textView superview] superview]]; // this should return you your current indexPath
    
    // From here on you can (switch) your indexPath.section or indexPath.row
    // as appropriate to get the textValue and assign it to a variable, for instance:
    if (indexPath.section == 0) {
        if (indexPath.row == 0) self.appdelegateObj.userObj.statusMessage = textView.text;

    [textView resignFirstResponder];
    }
    return YES;
}

- (IBAction)cancelAction:(id)sender {
     [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)doneAction:(id)sender {
    
}
@end
