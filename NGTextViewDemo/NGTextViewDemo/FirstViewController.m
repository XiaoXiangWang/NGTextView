//
//  FirstViewController.m
//  NGTextViewDemo
//
//  Created by 汪潇翔 on 15/6/4.
//  Copyright (c) 2015年 NG. All rights reserved.
//

#import "FirstViewController.h"
#import "NGTextView.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet NGTextView *textView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.placeHolder = @"DoDoDoDoDoDoDoDoDoDoDoDoDoDoDoDoDoDoDoDoDoDoDoDoDoDoDoDoDoDoDoDoDoDoDoDoDoDo.";
    self.textView.layer.borderColor = [UIColor redColor].CGColor;
    self.textView.layer.borderWidth = 2;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
