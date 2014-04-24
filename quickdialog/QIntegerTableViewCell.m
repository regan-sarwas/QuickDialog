//
// Copyright 2014 Regan Sarwas, National Park Service  - regan_sarwas@nps.gov
//
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
// file except in compliance with the License. You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distributed under
// the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
// ANY KIND, either express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

#import "QIntegerTableViewCell.h"
#import "QuickDialog.h"
@implementation QIntegerTableViewCell {
    NSNumberFormatter *_numberFormatter;
    UIStepper *_stepper;
}

- (QIntegerTableViewCell *)init {
    self = [self initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"QuickformIntegerElement"];
    if (self!=nil){
        [self createSubviews];
		self.selectionStyle = UITableViewCellSelectionStyleNone;
        _numberFormatter = [[NSNumberFormatter alloc] init];
        [_numberFormatter setMaximumFractionDigits:0];
        [_numberFormatter setMinimumFractionDigits:0];
        [_numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    };
    return self;
}

- (void)createSubviews {
    _textField = [[QTextField alloc] init];
    //[_textField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.keyboardType = UIKeyboardTypeDecimalPad;
    _textField.delegate = self;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [self.contentView addSubview:_textField];

    //Create Stepper
    _stepper = [[UIStepper alloc] init];
    [_stepper addTarget:self action:@selector(updateElementFromStepper:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:_stepper];

    [self setNeedsLayout];
}

- (QIntegerElement *)integerElement {
    return ((QIntegerElement *)_entryElement);
}

- (void)updateTextFieldFromElement {
    _textField.text = [_numberFormatter stringFromNumber:[self integerElement].numberValue];
}

- (void)updateStepperFromElement {
    NSInteger value = [self integerElement].numberValue.integerValue;
    _stepper.value = (double)value;
}

- (void)prepareForElement:(QEntryElement *)element inTableView:(QuickDialogTableView *)view {
    [super prepareForElement:element inTableView:view];
    _entryElement = element;
    [self updateTextFieldFromElement];
    [self updateStepperFromElement];
}

- (void)updateElementFromTextField:(NSString *)value {
    NSString *result = [[value componentsSeparatedByCharactersInSet:
                         [[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                        componentsJoinedByString:@""];
    NSInteger parsedValue = [_numberFormatter numberFromString:result].integerValue;
    [self integerElement].numberValue = [NSNumber numberWithInteger:parsedValue];
    [self updateStepperFromElement];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)replacement {
    BOOL shouldChange = YES;

    if([_entryElement.delegate respondsToSelector:@selector(QEntryShouldChangeCharactersInRange:withString:forElement:andCell:)])
        shouldChange = [_entryElement.delegate QEntryShouldChangeCharactersInRange:range withString:replacement forElement:_entryElement andCell:self];

    if( shouldChange ) {
        NSString *newValue = [_textField.text stringByReplacingCharactersInRange:range withString:replacement];
        [self updateElementFromTextField:newValue];
        [self updateTextFieldFromElement];
        [_entryElement handleEditingChanged:self];
    }
    return NO;
}

- (void)updateElementFromStepper:(UIStepper *)stepper
{
    [self integerElement].numberValue = @((int)stepper.value);
    [self updateTextFieldFromElement];
}

@end
