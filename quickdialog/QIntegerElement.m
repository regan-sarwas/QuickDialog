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

#import "QEntryTableViewCell.h"
#import "QIntegerTableViewCell.h"
#import "QIntegerElement.h"

@implementation QIntegerElement {

@protected
    NSInteger _minimumValue;
    NSInteger _maximumValue;
}

@synthesize numberValue = _numberValue;
@synthesize minimumValue = _minimumValue;
@synthesize maximumValue = _maximumValue;

- (QIntegerElement *)initWithTitle:(NSString *)title value:(NSNumber *)value {
    self = [super initWithTitle:title Value:nil];
    if (self) {
        [self myInit:value];
    }
    return self;
}

- (QIntegerElement *)initWithValue:(NSNumber *)value {
    self = [super init];
    if (self) {
        [self myInit:value];
    }
    return self;
}

- (QIntegerElement *)init {
    self = [super init];
    if (self) {
        [self myInit:@0];
    }
    return self;
}

- (void)myInit:(NSNumber *)value
{
    _numberValue = value;
    self.keyboardType = UIKeyboardTypeDecimalPad;
    // 0..100 matches the defaults for UIStepper, so these seem like good defaults for us.
    NSInteger intValue = value.integerValue;
    _minimumValue = (intValue < 0) ? intValue : 0;
    _maximumValue = (100 < intValue) ? intValue : 100;
}

- (void)setMinimumValue:(NSInteger)minimumValue {
    _minimumValue = minimumValue;
    if (_numberValue.integerValue < minimumValue)
        _numberValue = @(minimumValue);
}

- (void)setMaximumValue:(NSInteger)maximumValue {
    _maximumValue = maximumValue;
    if (maximumValue < _numberValue.integerValue)
        _numberValue = @(maximumValue);
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {

    QIntegerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformIntegerElement"];
    if (cell==nil){
        cell = [[QIntegerTableViewCell alloc] init];
    }
    [cell prepareForElement:self inTableView:tableView];
    cell.textField.userInteractionEnabled = self.enabled;

    return cell;
}

- (void)fetchValueIntoObject:(id)obj {
	if (_key==nil)
		return;
    [obj setValue:_numberValue forKey:_key];
}

@end
