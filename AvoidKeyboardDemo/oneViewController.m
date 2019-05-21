//
//  oneViewController.m
//  AvoidKeyboardDemo
//
//  Created by admin on 21/5/2019.
//  Copyright © 2019 MyCompany. All rights reserved.
//
#import "textviewCell.h"

#import "oneViewController.h"

@interface oneViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tvContent;
@property (nonatomic, strong) UITextView *theEditTextView;
@property (nonatomic, assign) CGFloat theKeyMin;

@end

@implementation oneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
//    _tvContent.estimatedRowHeight = 44;
//    _tvContent.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark - 键盘躲避
- (void)showKeyboard:(NSNotification *)noti
{
    
    self.view.transform = CGAffineTransformIdentity;
    UIView *editView =   _theEditTextView ;
    
    CGRect tfRect = [editView.superview convertRect:editView.frame toView:self.view];
    NSValue *value = noti.userInfo[@"UIKeyboardFrameEndUserInfoKey"];
    NSLog(@"%@", value);
    CGRect keyBoardF = [value CGRectValue];
    
    CGFloat animationTime = [noti.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    CGFloat _editMaxY = CGRectGetMaxY(tfRect);
    CGFloat _keyBoardMinY = CGRectGetMinY(keyBoardF);
    _theKeyMin = _keyBoardMinY;

    NSLog(@"%f %f", _editMaxY, _keyBoardMinY);
    if (_keyBoardMinY < _editMaxY) {
        CGFloat moveDistance = _editMaxY - _keyBoardMinY;
        [UIView animateWithDuration:animationTime animations:^{
            self.view.transform = CGAffineTransformTranslate(self.view.transform, 0, -moveDistance);
        }];
        
    }
}

- (void)hideKeyboard:(NSNotification *)noti
{
    //    NSLog(@"%@", noti);
    self.view.transform = CGAffineTransformIdentity;
    _theKeyMin = [UIScreen mainScreen].bounds.size.height;
}





-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 44;
//}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden=@"iden";
    textviewCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
      cell=[[[NSBundle mainBundle] loadNibNamed:@"textviewCell" owner:self options:nil] firstObject];
        cell.textview.delegate=self;
    }
    return cell;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _theEditTextView = textView;
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView
{
      [_tvContent beginUpdates];
    self.view.transform = CGAffineTransformIdentity;
    UIView *editView =   _theEditTextView ;
    
    CGRect tfRect = [editView.superview convertRect:editView.frame toView:self.view];
    
    CGFloat _editMaxY = CGRectGetMaxY(tfRect);
 
    if (_theKeyMin < _editMaxY) {
        CGFloat moveDistance = _editMaxY - _theKeyMin;
//        [UIView animateWithDuration:0.1 animations:^{
            self.view.transform = CGAffineTransformTranslate(self.view.transform, 0, -moveDistance);
//        }];
        
    }

    
        [_tvContent endUpdates];
    
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
