//
//  ProductRemarksCell.m
//  XProject
//
//  Created by laughing on 2019/3/26.
//  Copyright © 2019年 610715. All rights reserved.
//  输入备注cell

#import "ProductRemarksCell.h"
#import <Masonry/Masonry.h>

@interface ProductRemarksCell ()
<
    UITextFieldDelegate
>
@property (nonatomic, strong) UITextField *inputTextField;

@end

@implementation ProductRemarksCell
@synthesize model = _model;
@synthesize delegate = _delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexColorString:@"f4f4f4"];
        [self addSubview:self.inputTextField];
        
        [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self).mas_equalTo(UIEdgeInsetsMake(5, 5, 5, 5));
        }];
    }
    return self;
}

+(NSString *)cellIdentifierl
{
    return NSStringFromClass(self.class);
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length) {
        if ([_model isKindOfClass:[ProductRemarksModel class]]) {
            ProductRemarksModel *remarkModel = _model;
            remarkModel.remakrContent = textField.text;
        }
    }
}

#pragma mark - setter

-(void)setModel:(id<CollectionDatasourceProtocol>)model
{
    _model = model;
    
    if ([_model isKindOfClass:[ProductRemarksModel class]]) {
        ProductRemarksModel *remarkModel = _model;
        if (remarkModel.remakrContent.length) {
            self.inputTextField.text = remarkModel.remakrContent;
        }
    }
}

-(UITextField *)inputTextField
{
    if (!_inputTextField) {
        _inputTextField = ({
            UITextField *tf = [[UITextField alloc] init];
            tf.placeholder = @"请输入备注";
            tf.borderStyle = UITextBorderStyleRoundedRect;
            tf.backgroundColor = ZFCOLOR_WHITE;
            tf.delegate = self;
            tf;
        });
    }
    return _inputTextField;
}

@end

@implementation ProductRemarksModel

@end
